import SwiftUI
import Domain
import HomeFeature
import ScheduleFeature
import DDayFeature
import SettingsFeature
import ComposableArchitecture

public struct MainTabBarView: View {
    public let store: StoreOf<MainTabBarReducer>
    @Dependency(\.appStorageRepository) var storage
    @Dependency(\.colorProvider) var colorProvider
    @Dependency(\.imageProvider) var imageProvider
    public let bannerView: any UIViewRepresentable
    @State public var adSize: CGSize = CGSize(width: 360, height: 60)
    @State private var bannerAdHeight: Double = 60
    
    public init(store: StoreOf<MainTabBarReducer>, bannerView: any UIViewRepresentable, adSize: CGSize) {
        self.store = store
        self.bannerView = bannerView
        self.adSize = adSize
        self._bannerAdHeight = State(initialValue: self.storage.get(.bannerAdHeight, defaultValue: 60.0))
    }
    
    public var body: some View {
        GeometryReader { geometry in
            let screenHeight = geometry.size.height
            let calculatedHeight = screenHeight * 0.074
            
            WithViewStore(store, observe: \.selectedTab) { viewStore in
                ZStack {
                    TabView(selection: viewStore.binding(send: MainTabBarReducer.Action.selectedTabChanged)) {
                        NavigationStack {
                            HomeView(store: store.scope(state: \.home, action: \.home))
                        }
                        .tag(MainTabBarReducer.Tab.home)
                        .tabItem {
                            Image(uiImage: store.selectedTab == .home ? imageProvider.image(asset: .homeTabSelect) : imageProvider.image(asset: .homeTabUnselect))
                            Text("Home")
                        }
                        
                        NavigationStack {
                            VStack {
                                ScheduleView(store: store.scope(state: \.schedule, action: \.schedule))
                            }
                        }
                        .tag(MainTabBarReducer.Tab.schedule)
                        .tabItem {
                            Image(uiImage: store.selectedTab == .schedule ? imageProvider.image(asset: .scheduleTabSelect) : imageProvider.image(asset: .scheduleTabUnselect))
                            Text("Schedule")
                        }
                        
                        NavigationStack {
                            DDayView(store: store.scope(state: \.dday, action: \.dday))
                        }
                        .tag(MainTabBarReducer.Tab.dday)
                        .tabItem {
                            Image(uiImage: store.selectedTab == .dday ? imageProvider.image(asset: .dDayTabSelect) : imageProvider.image(asset: .dDayTabUnselect))
                            Text("D-Day")
                        }
                        
                        NavigationStack {
                            SettingsView(store: store.scope(state: \.settings, action: \.settings))
                        }
                        .tag(MainTabBarReducer.Tab.settings)
                        .tabItem {
                            Image(uiImage: store.selectedTab == .settings ? imageProvider.image(asset: .settingsTabSelect) : imageProvider.image(asset: .settingsTabUnselect))
                            Text("Settings")
                        }
                    }
                    .tint(colorProvider.color(asset: .baseFontColor))
                    .onAppear {
                        adSize.width = geometry.size.width
                        bannerAdHeight = calculatedHeight
                    }
                    .onChange(of: geometry.size.width, { oldValue, newValue in
                        adSize.width = newValue
                    })
                    .overlay(alignment: .top) {
                        AnyView(bannerView)
                            .frame(width: adSize.width, height: adSize.height)
                            .background(.clear)
                            .padding(.top, UIDevice.current.userInterfaceIdiom == .pad ? 50 : 0)
                    }
                }
            }
        }
    }
}

