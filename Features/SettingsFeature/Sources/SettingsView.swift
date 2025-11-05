import SwiftUI
import Utilities
import ComposableArchitecture

public struct SettingsView: View {
    @Bindable
    var store: StoreOf<SettingsReducer>
    @Dependency(\.appStorageRepository) var storage
    @Dependency(\.localeService) var localeService
    @Dependency(\.colorProvider) var colorProvider
    @Dependency(\.imageProvider) var imageProvider
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
                                }
                            } label: {
                                switch menuItem {
                                case .appInfo:
                                    Text(localeService.localized(forKey: .settingsMenuAppInfo))
                                        .foregroundStyle(colorProvider.color(asset: .baseFontColor))
                                case .profile:
                                    Text(localeService.localized(forKey: .settingsMenuProfile))
                                        .foregroundStyle(colorProvider.color(asset: .baseFontColor))
                                case .theme:
                                    Text(localeService.localized(forKey: .settingsMenuTheme))
                                        .foregroundStyle(colorProvider.color(asset: .baseFontColor))
                                }
                               
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
                Image(uiImage: imageProvider.image(asset: .baseBackground))
                    .resizable()
                    .ignoresSafeArea()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

