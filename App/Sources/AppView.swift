import SwiftUI
import SplashFeature
import MainTabBarFeature
import ComposableArchitecture
import GoogleMobileAds

struct AppView: View {
    public let store: StoreOf<AppReducer>
    @State private var adSize: AdSize = AdSize()
    
    var body: some View {
        GeometryReader { geometry in
            let screenHeight = geometry.size.height
            let calculatedHeight = screenHeight * 0.074
            
            WithViewStore(store, observe: { $0 }) { viewStore in
                ZStack {
                    if viewStore.showSplash {
                        SplashView(
                            store: store.scope(
                                state: \.splash,
                                action: \.splash
                            ),
                            onFinishSplash: {
                                viewStore.send(.splashDidFinish)
                            }
                        )
                    } else {
                        MainTabBarView(
                            store: store.scope(
                                state: \.mainTabBar,
                                action: \.mainTabBar
                            ),
                            bannerView: BannerViewContainer(adSize: $adSize),
                            adSize: CGSize(width: adSize.size.width, height: adSize.size.height)
                        )
                    }
                }
                .onChange(of: viewStore.didFinishSplash) { _, newValue in
                    if newValue {
                        if !viewStore.shouldRequestTracking {
                            viewStore.send(.executeTrackingRequest)
                        }
                    }
                }
                .onChange(of: viewStore.didCompleteTrackingRequest) { _, newValue in
                    if newValue {
                        adSize = currentOrientationAnchoredAdaptiveBanner(width: geometry.size.width)
                        adSize.size.height = calculatedHeight
                    }
                }
                .onChange(of: geometry.size.width) { _, newValue in
                    adSize = currentOrientationAnchoredAdaptiveBanner(width: newValue)
                }
            }
        }
    }
}
