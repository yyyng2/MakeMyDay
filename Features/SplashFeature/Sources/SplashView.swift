import SwiftUI
import Domain
import Resources
import Utilities
import ComposableArchitecture

public struct SplashView: View {
    let store: StoreOf<SplashReducer>
    let onFinishSplash: () -> Void
    
    public init(store: StoreOf<SplashReducer>, onFinishSplash: @escaping () -> Void) {
        self.store = store
        self.onFinishSplash = onFinishSplash
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ZStack {
                ResourcesAsset.Assets.baseForeground.swiftUIColor.ignoresSafeArea()
                
                VStack {
                    Image(uiImage: ResourcesAsset.Assets.splashIcon.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .clipped()
                        .opacity(viewStore.isCheckingVersion ? 1 : 0)
                    
                    Text("Make My Day")
                        .foregroundStyle(ResourcesAsset.Assets.accentColor.swiftUIColor)
                        .opacity(viewStore.isCheckingVersion ? 1 : 0)
                }
                .animation(.easeInOut(duration: 0.5), value: viewStore.isCheckingVersion)
            }
            .alert("splash_update_title".localized(), isPresented: viewStore.binding(
                get: \.showUpdateAlert,
                send: { _ in .cancelUpdateTapped }
            )) {
                Button("splash_update_confirm".localized()) {
                    viewStore.send(.updateButtonTapped)
                }
                
                Button("splash_update_cancel".localized(), role: .cancel) {
                    viewStore.send(.cancelUpdateTapped)
                }
            } message: {
                Text("splash_update_info".localized())
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
