import SwiftUI
import Utilities
import Resources
import ComposableArchitecture

public struct SettingsView: View {
    @Bindable
    var store: StoreOf<SettingsReducer>
    @Dependency(\.appStorageRepository) var storage
    @State private var bannerAdHeight: Double = 60
    
    public init(store: StoreOf<SettingsReducer>) {
        self.store = store
        self._bannerAdHeight = State(initialValue: self.storage.get(.bannerAdHeight, defaultValue: 60.0))
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
                    let storedHeight = storage.get(.bannerAdHeight, defaultValue: 60.0)
                    if bannerAdHeight < storedHeight {
                        bannerAdHeight = storedHeight
                    }
                }
                .onChange(of: bannerAdHeight) { oldValue, newValue in
                    storage.set(.bannerAdHeight, value: newValue)
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

