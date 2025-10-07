import SwiftUI
import Utilities
import Resources
import ComposableArchitecture

public struct SettingsView: View {
    @Bindable
    var store: StoreOf<SettingsReducer>
    @AppStorage("bannerAdHeight") private var storedBannerAdHeight: Double = 60
    @State private var bannerAdHeight: Double = 60
    
    public init(store: StoreOf<SettingsReducer>) {
        self.store = store
    }
    
    public var body: some View {
        ZStack {
            NavigationStackStore(
                store.scope(state: \.path, action: \.path)
            ) {
                VStack {
                    Spacer()
                        .frame(height: UIDevice.current.userInterfaceIdiom == .pad ? 70 : 50)
                    
                    List {
                        ForEach(SettingsReducer.MenuItem.allCases, id: \.self) { menuItem in
                            Button {
                                switch menuItem {
                                case .appInfo:
                                    store.send(.pushAppInfo)
                                case .profile:
                                    store.send(.pushProfile)
                                case .theme:
                                    store.send(.pushTheme)
                                    //                                case .openSource:
                                    //                                    store.send(.pushOpenSource)
                                }
                            } label: {
                                Text(menuItem.rawValue.localized())
                                    .foregroundStyle(ResourcesAsset.Assets.baseFontColor.swiftUIColor)
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .onAppear {
                    if bannerAdHeight < storedBannerAdHeight {
                        bannerAdHeight = storedBannerAdHeight
                    }
                }
                .onChange(of: bannerAdHeight) { oldValue, newValue in
                    storedBannerAdHeight = newValue
                }
            } destination: { store in
                switch store.case {
                case .appInfo(let appInfoStore):
                    SettingsAppInfoView(store: appInfoStore)
                case .profile(let profileStore):
                    SettingsProfileView(store: profileStore)
                case .theme(let themeStroe):
                    SettingsThemeView(store: themeStroe)
                }
            }
            .presentationBackground(.clear)
            .backgroundStyle(.clear)
            .background {
                Image(uiImage: ResourcesAsset.Assets.baseBackground.image)
                    .resizable()
                    .ignoresSafeArea()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

