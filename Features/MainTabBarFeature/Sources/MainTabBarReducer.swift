import Foundation
import Core
import Domain
import HomeFeature
import ScheduleFeature
import DDayFeature
import SettingsFeature
import ComposableArchitecture

@Reducer
public struct MainTabBarReducer {
    public enum Tab: Equatable, CaseIterable {
        case home
        case schedule
        case dday
        case settings
        
        public var title: String {
            switch self {
                            case .home: return "홈"
            case .schedule: return "일정"
            case .dday: return "디데이"
            case .settings: return "설정"
            }
        }
        
        public var iconName: String {
            switch self {
                            case .home: return "home"
            case .schedule: return "calendar"
            case .dday: return "clock"
            case .settings: return "gearshape"
            }
        }
    }
    
    @ObservableState
    public struct State: Equatable {
        public var selectedTab: Tab = .home
        public var home: HomeReducer.State
        public var schedule: ScheduleReducer.State
        public var dday: DDayReducer.State
        public var settings: SettingsReducer.State
        public init() {
            self.home = HomeReducer.State()
            self.schedule = ScheduleReducer.State()
            self.dday = DDayReducer.State()
            self.settings = SettingsReducer.State()
        }
    }
    
    public init() {}
    
    public enum Action {
        case selectedTabChanged(Tab)
        case home(HomeReducer.Action)
        case schedule(ScheduleReducer.Action)
        case dday(DDayReducer.Action)
        case settings(SettingsReducer.Action)
    }
    
    public var body: some ReducerOf<Self> {
        Scope(state: \.home, action: \.home) {
            HomeReducer()
        }
        
        Scope(state: \.schedule, action: \.schedule) {
            ScheduleReducer()
        }
        
        Scope(state: \.dday, action: \.dday) {
            DDayReducer()
        }
        
        Scope(state: \.settings, action: \.settings) {
            SettingsReducer()
        }
        
        Reduce { state, action in
            switch action {
            case let .selectedTabChanged(tab):
                state.selectedTab = tab
                return .none
                
            case .home, .schedule, .dday, .settings:
                return .none
            }
        }
    }
}
