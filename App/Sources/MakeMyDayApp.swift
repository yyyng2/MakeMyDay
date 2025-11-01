import SwiftUI
import AppTrackingTransparency
import ComposableArchitecture
import GoogleMobileAds

@main
struct MakeMyDayApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    private let store = Store(initialState: AppReducer.State()) {
        AppReducer()
    }

    var body: some Scene {
        WindowGroup {
            WithViewStore(store, observe: { $0 }) { viewStore in
                AppView(store: store)
                    .onChange(of: viewStore.shouldRequestTracking) { _, should in
                        if should {
                            requestTrackingAndStartAds {
                                viewStore.send(.trackingRequestCompleted)
                            }
                        }
                    }
            }
        }
    }
    
    private func requestTrackingAndStartAds(completionHandler: @escaping () -> Void) {
        let authorizationStatus = ATTrackingManager.trackingAuthorizationStatus
        
        switch authorizationStatus {
        case .notDetermined:
            ATTrackingManager.requestTrackingAuthorization { _ in
                Task {
                    await MobileAds.shared.start()
                    await MainActor.run {
                        completionHandler()
                    }
                }
            }
        default:
            Task {
                await MobileAds.shared.start()
                await MainActor.run {
                    completionHandler()
                }
            }
        }
    }
}
