import Foundation
import ComposableArchitecture

@Reducer
public struct SettingsReducer {
    public enum MenuItem: String, CaseIterable {
        case appInfo = "settings_menu_appInfo"
        case profile = "settings_menu_profile"
        case theme = "settings_menu_theme"
//        case openSource = "오픈소스"
    }
    
    @Reducer(state: .equatable)
    public enum Path {
        case appInfo(SettingsAppInfoReducer)
        case profile(SettingsProfileReducer)
        case theme(SettingsThemeReducer)
        //         case openSource(OpenSourceReducer)
    }
    
    @ObservableState
    public struct State: Equatable {
        public var path = StackState<Path.State>()
        public var appInfo: SettingsAppInfoReducer.State
        public var profile: SettingsProfileReducer.State
        public var theme: SettingsThemeReducer.State
        public init() {
            self.appInfo = SettingsAppInfoReducer.State()
            self.profile = SettingsProfileReducer.State()
            self.theme = SettingsThemeReducer.State()
        }
    }
    
    public enum Action {
        case path(StackAction<Path.State, Path.Action>)
        case appInfo(SettingsAppInfoReducer.Action)
        case profile(SettingsProfileReducer.Action)
        case theme(SettingsThemeReducer.Action)
        case onAppear
        case pushAppInfo
        case pushProfile
        case pushTheme
//              case pushOpenSource
    }
    
    @Dependency(\.appStorageRepository) var storage
    
    public init() {}
    
    public var body: some ReducerOf<Self> {
        Scope(state: \.appInfo, action: \.appInfo) {
            SettingsAppInfoReducer()
        }
        
        Scope(state: \.profile, action: \.profile) {
            SettingsProfileReducer()
        }
        
        Scope(state: \.theme, action: \.theme) {
            SettingsThemeReducer()
        }
        
        Reduce { state, action in
            switch action {
            case let .path(.element(id, action)):
                switch action {
                case .appInfo(.dismissButtonTapped):
                    if let index = state.path.ids.firstIndex(of: id) {
                        state.path.remove(at: index)
                    }
                    return .none
                case .profile(.dismissButtonTapped), .profile(.saveButtonTapped):
                    if let index = state.path.ids.firstIndex(of: id) {
                        state.path.remove(at: index)
                    }
                    return .none
                case .theme(.dismissButtonTapped):
                    if let index = state.path.ids.firstIndex(of: id) {
                        state.path.remove(at: index)
                    }
                    return .none
                default:
                    return .none
                }
            case .onAppear:
                return .none
            case .appInfo(_):
                //                state.path.append(state.appInfo)
                return .none
            case .profile(_):
                return .none
            case .theme(_):
                return .none
            case .pushAppInfo:
                state.path.append(.appInfo(state.appInfo))
                return .none
            case .pushProfile:
                state.path.append(.profile(state.profile))
                return .none
            case .pushTheme:
                state.path.append(.theme(state.theme))
                return .none
            case .path(.popFrom(id: _)):
                return .none
            case .path(.push(id: _, state: _)):
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}
