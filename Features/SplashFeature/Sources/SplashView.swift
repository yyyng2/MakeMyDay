import SwiftUI
import Utilities
import ComposableArchitecture

public struct SplashView: View {
    let store: StoreOf<SplashReducer>
    @Dependency(\.localeService) var localeService
    @Dependency(\.colorProvider) var colorProvider
    @Dependency(\.imageProvider) var imageProvider
    let onFinishSplash: () -> Void
    
    public init(store: StoreOf<SplashReducer>, onFinishSplash: @escaping () -> Void) {
        self.store = store
        self.onFinishSplash = onFinishSplash
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ZStack {
                colorProvider.color(asset: .baseForeground).ignoresSafeArea()
                
                VStack {
                    Image(uiImage: imageProvider.image(asset: .splashIcon))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .clipped()
                        .opacity(viewStore.isCheckingVersion ? 1 : 0)
                    
                    Text("Make My Day")
                        .foregroundStyle(colorProvider.color(asset: .AccentColor))
                        .opacity(viewStore.isCheckingVersion ? 1 : 0)
                }
                .animation(.easeInOut(duration: 0.5), value: viewStore.isCheckingVersion)
            }
            .alert(localeService.localized(forKey: .splashUpdateTitle), isPresented: viewStore.binding(
                get: \.showUpdateAlert,
                send: { _ in .cancelUpdateTapped }
            )) {
                Button(localeService.localized(forKey: .splashUpdateConfirm)) {
                    viewStore.send(.updateButtonTapped)
                }
                
                Button(localeService.localized(forKey: .splashUpdateCancel), role: .cancel) {
                    viewStore.send(.cancelUpdateTapped)
                }
            } message: {
                Text(localeService.localized(forKey: .splashUpdateInfo))
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
            .onChange(of: viewStore.state) {
                if !viewStore.isCheckingVersion && !viewStore.showUpdateAlert {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        onFinishSplash()
                    }
                }
            }
        }
    }
}
