import SwiftUI
import Core
import ComposableArchitecture

@Reducer
public struct SplashReducer {
    public struct State: Equatable {
        public var isCheckingVersion: Bool
        public var showUpdateAlert: Bool
        public var isLatestVersion: Bool
        
        public init(
            isCheckingVersion: Bool = true,
            showUpdateAlert: Bool = false,
            isLatestVersion: Bool = false
        ) {
            self.isCheckingVersion = isCheckingVersion
            self.showUpdateAlert = showUpdateAlert
            self.isLatestVersion = isLatestVersion
        }
    }
    
    public enum Action {
        case onAppear
        case checkVersionResponse(Result<Bool, Error>)
        case updateButtonTapped
        case cancelUpdateTapped
        case finishSplash
    }
    
    @Dependency(\.appVersionService) var appVersionService
    
    public init() {}
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.isCheckingVersion = true
                return .run { send in
                    let isLatest = appVersionService.isLatestVersion
                    await send(.checkVersionResponse(.success(isLatest())))
                } catch: { error, send in
                    await send(.checkVersionResponse(.failure(error)))
                }
                
            case let .checkVersionResponse(.success(isLatest)):
                state.isCheckingVersion = false
                state.isLatestVersion = isLatest
                state.showUpdateAlert = !isLatest
                
                if isLatest {
                    return .send(.finishSplash)
                }
                return .none
                
            case .checkVersionResponse(.failure):
                state.isCheckingVersion = false
                return .send(.finishSplash)
                
            case .updateButtonTapped:
                @Environment(\.openURL) var openURL: OpenURLAction
                if let url = appVersionService.getUpdateURL() {
                    openURL(url)
                }
                state.showUpdateAlert = false
                return .send(.finishSplash)
                
            case .cancelUpdateTapped:
                state.showUpdateAlert = false
                return .send(.finishSplash)
                
            case .finishSplash:
                return .none
            }
        }
    }
}
