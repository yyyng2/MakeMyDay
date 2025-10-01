import SwiftUI
import Domain
import Data
import Services
import ComposableArchitecture

extension DependencyValues {
    public var scheduleRepository: ScheduleRepositoryProtocol {
        get { self[ScheduleRepositoryKey.self] }
        set { self[ScheduleRepositoryKey.self] = newValue }
    }
    
    public var ddayRepository: DDayRepositoryProtocol {
        get { self[DDayRepositoryKey.self] }
        set { self[DDayRepositoryKey.self] = newValue }
    }
    
    public var appVersionService: AppVersionServiceProtocol {
        get { self[AppVersionServiceKey.self] }
        set { self[AppVersionServiceKey.self] = newValue }
    }
    
    public var userDefaultsClient: UserDefaultsClient {
        get { self[UserDefaultsClientKey.self] }
        set { self[UserDefaultsClientKey.self] = newValue }
    }
    
//    public var weatherService: WeatherServiceProtocol {
//        get { self[WeatherServiceKey.self] }
//        set { self[WeatherServiceKey.self] = newValue }
//    }
    
//    public var locationService: LocationServiceProtocol {
//        get { self[LocationServiceKey.self] }
//        set { self[LocationServiceKey.self] = newValue }
//    }
    
    var openURL: OpenURLEffect {
        get { self[OpenURLKey.self] }
        set { self[OpenURLKey.self] = newValue }
    }
}

@MainActor
private let sharedModelContainer = ModelContainerClient.create(schemas: [
    Schedule.self, DDay.self
])

@MainActor
private enum ScheduleRepositoryKey: @preconcurrency DependencyKey {
    static var liveValue: ScheduleRepositoryProtocol = {
        return ScheduleRepository(modelContainer: sharedModelContainer)
    }()
    
    static let testValue: ScheduleRepositoryProtocol = MockScheduleRepository()
}

@MainActor
private enum DDayRepositoryKey: @preconcurrency DependencyKey {
    static let liveValue: DDayRepositoryProtocol = {
        return DDayRepository(modelContainer: sharedModelContainer)
    }()
    
    static let testValue: DDayRepositoryProtocol = MockDDayRepository()
}

private enum AppVersionServiceKey: DependencyKey {
    static let liveValue: AppVersionServiceProtocol = LiveAppVersionService()
    
    static let testValue: AppVersionServiceProtocol = MockAppVersionService()
}

//private enum WeatherServiceKey: DependencyKey {
//    static let liveValue: WeatherServiceProtocol = LiveWeatherService()
//    
//    static let testValue: WeatherServiceProtocol = MockWeatherService()
//}
//
//private enum LocationServiceKey: DependencyKey {
//    static let liveValue: LocationServiceProtocol = LocationService()
//    
//    static let testValue: LocationServiceProtocol = MockLocationService()
//}

private enum OpenURLKey: DependencyKey {
    static let liveValue = OpenURLEffect { url in
        await UIApplication.shared.open(url)
    }
    
    static let testValue = OpenURLEffect { _ in true }
}

private enum UserDefaultsClientKey: DependencyKey {
    static let liveValue = UserDefaultsClient(
        getBool: { key in
            if UserDefaults.standard.object(forKey: key.rawValue) == nil {
                if key == .isLightTheme {
                    return true
                }
                return false
            }
            return UserDefaults.standard.bool(forKey: key.rawValue)
        },
        setBool: { key, value in
            UserDefaults.standard.set(value, forKey: key.rawValue)
        },
        getString: { key in
            UserDefaults.standard.string(forKey: key.rawValue) ?? ""
        },
        setString: { key, value in
            UserDefaults.standard.set(value, forKey: key.rawValue)
        },
        getData: { key in
            UserDefaults.standard.data(forKey: key.rawValue)
        },
        setData: { key, data in
            UserDefaults.standard.set(data, forKey: key.rawValue)
        }
    )
    
    static let testValue = UserDefaultsClient(
        getBool: { _ in false },
        setBool: { _, _ in },
        getString: { _ in "" },
        setString: { _, _ in },
        getData: { _ in nil },
        setData: { _, _ in }
    )
}
