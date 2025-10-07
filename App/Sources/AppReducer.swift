import SwiftUI
import Core
import Data
import Domain
import SplashFeature
import MainTabBarFeature
import ComposableArchitecture

@Reducer
struct AppReducer {
    struct State: Equatable {
        var showSplash: Bool = true
        var didFinishSplash: Bool = false
        var shouldRequestTracking: Bool = false
        var didCompleteTrackingRequest: Bool = false
        var isLightTheme: Bool = true
        var splash = SplashReducer.State()
        var mainTabBar = MainTabBarReducer.State()
    }
    
    enum Action {
        case splash(SplashReducer.Action)
        case mainTabBar(MainTabBarReducer.Action)
        case splashDidFinish
        case executeTrackingRequest
        case trackingRequestCompleted
        case onAppear
    }
    
    @Dependency(\.userDefaultsClient) var userDefaultsClient
    
    var body: some ReducerOf<Self> {
        Scope(state: \.splash, action: \.splash) {
            SplashReducer()
        }
        Scope(state: \.mainTabBar, action: \.mainTabBar) {
            MainTabBarReducer()
        }
        
        Reduce { state, action in
            switch action {
            case .splash(_):
                return .none
                
            case .mainTabBar(_):
                return .none
                
            case .splashDidFinish:
                state.didFinishSplash = true
                return .none
            case .executeTrackingRequest:
                state.shouldRequestTracking = true
                return .none
            
            case .trackingRequestCompleted:
                state.didCompleteTrackingRequest = true
                state.showSplash = false
                return .none
                
            case .onAppear:
                state.isLightTheme = userDefaultsClient.getBool(UserDefaultsKey.isLightTheme)
                
                let scenes = UIApplication.shared.connectedScenes
                let windowScene = scenes.first as? UIWindowScene
                windowScene?.windows.forEach { window in
                    window.overrideUserInterfaceStyle = state.isLightTheme ? .light : .dark
                }
                return .none
            }
        }
    }
}
