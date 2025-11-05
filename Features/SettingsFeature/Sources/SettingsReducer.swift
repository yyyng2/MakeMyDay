import Foundation
import ComposableArchitecture

@Reducer
public struct SettingsReducer {
    public enum MenuItem: CaseIterable {
        case appInfo
        case profile
        case theme
    }
    
    @Reducer
    public enum Path {
        case appInfo(SettingsAppInfoReducer)
        case profile(SettingsProfileReducer)
        case theme(SettingsThemeReducer)
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
        case path(StackActionOf<Path>)
        case appInfo(SettingsAppInfoReducer.Action)
        case profile(SettingsProfileReducer.Action)
        case theme(SettingsThemeReducer.Action)
        case onAppear
        case pushAppInfo
        case pushProfile
        case pushTheme
    }
    
    @Dependency(\.appStorageRepository) var storage
    
    public init() {}
    
    public var body: some ReducerOf<Self> {
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
            case .appInfo(_), .profile(_), .theme(_):
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
            case .path(.popFrom(id: _)), .path(.push(id: _, state: _)):
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}

extension SettingsReducer.Path.State: Equatable { }
