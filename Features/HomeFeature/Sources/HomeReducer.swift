import SwiftUI
import Core
import Domain
import Resources
import Utilities
import ComposableArchitecture

@Reducer
public struct HomeReducer {
    @ObservableState
    public struct State: Equatable {
        public var currentImage: UIImage = ResourcesAsset.Assets.dIcon.image
        public var isUsingCustomImage: Bool = false
        public var userNickname: String = "D"
        public var welcomeMessage: String = "Welcome! :D"
        public var todaySchedules: [Schedule] = []
        public var todayDDays: [DDay] = []
        public var showMenuOptions: Bool = false
        public var chatMessages: [ChatMessage] = []
        public var showWeatherInfo: Bool = false
        public var currentWeather: WeatherInfo?
        public var showLocationAlert: Bool = false
        public var showWeatherAlert: Bool = false
        public var alertMessage: String = ""
        
        public init() {}
    }
    
    public enum Action {
        case onAppear
        case textFieldTapped
        case dismissMenu
        case magic8BallTapped
        case weatherTapped
        case clearChat
        case didFetchSchedules([Schedule])
        case didFetchDDays([DDay])
        case didFetchWeather(WeatherInfo?)
        case showLocationPermissionAlert
        case showWeatherErrorAlert(String)
        case dismissAlert
    }
    
    @Dependency(\.userDefaultsClient) var userDefaultsClient
    @Dependency(\.appStorageRepository) var storage
    @Dependency(\.scheduleRepository) var scheduleRepository
    @Dependency(\.ddayRepository) var ddayRepository
//    @Dependency(\.locationService) var locationService
//    @Dependency(\.weatherService) var weatherService
    
    public init() {}
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                let isCustom = userDefaultsClient.getBool(UserDefaultsKey.isUsingCustomImage)
                var nickname = userDefaultsClient.getString(UserDefaultsKey.userNickname)
                if nickname == "" {
                    nickname = "D"
                }
                state.userNickname = nickname
                
                if isCustom,
                   let imageData = userDefaultsClient.getData(UserDefaultsKey.userProfileImage),
                   let savedImage = UIImage(data: imageData) {
                    state.currentImage = savedImage
                    state.isUsingCustomImage = true
                } else {
                    state.currentImage = ResourcesAsset.Assets.dIcon.image
                    state.isUsingCustomImage = false
                }
                
                let welcomeMessages = ["home_welcome_nice".localized(), "home_welcome_wonderful".localized(), "home_welcome_lovely".localized()]
                state.welcomeMessage = welcomeMessages.randomElement() ?? "Welcome! :D"
                
                return .run { [scheduleRepository, ddayRepository] send in
                    await MainActor.run {
                        do {
                            let schedules = try scheduleRepository.fetchAllSchedules()
                            send(.didFetchSchedules(schedules))
                            
                            let ddays = try ddayRepository.fetchAllDDays()
                            send(.didFetchDDays(ddays))
                            
//                            let lastWeatherCheck = userDefaultsClient.getString(UserDefaultsKey.lastDateWeatherChecked)
//                            let formatter = DateFormatter()
//                            formatter.dateFormat = "yyyy-MM-dd"
//                            let today = formatter.string(from: Date())
                            
//                            if lastWeatherCheck == today,
//                               let weatherData = userDefaultsClient.getData(UserDefaultsKey.cachedWeatherData),
//                               let weather = try? JSONDecoder().decode(WeatherInfo.self, from: weatherData) {
//                                send(.didFetchWeather(weather))
//                            }
                        } catch {
                            print("Error fetching data: \(error)")
                        }
                    }
                }
                
            case .textFieldTapped:
                state.showMenuOptions = !state.showMenuOptions
                return .none
                
            case .dismissMenu:
                state.showMenuOptions = false
                return .none
                
            case .magic8BallTapped:
                state.showMenuOptions = false
                
                state.chatMessages.append(ChatMessage(
                    id: UUID(),
                    text: "내 고민 어떻게 생각해?",
                    isUser: true
                ))
                
                let responses = [
                    "그럼요, 당연하죠!",
                    "분명히 그럴 거예요.",
                    "의심의 여지가 없어요.",
                    "확실히 그래요.",
                    "믿어도 좋아요.",
                    "제가 보기엔 그런것 같아요.",
                    "아마도요.",
                    "전망이 좋아요.",
                    "신호가 흐릿해요.",
                    "다시 생각해보고 물어보세요.",
                    "지금은 예측할 수 없어요.",
                    "집중해서 다시 물어보세요.",
                    "기대는 하지마세요.",
                    "제 의견은 부정적이에요.",
                    "전망이 별로예요.",
                    "매우 의심해봐야해요.",
                    "일단 상황을 지켜봐요.",
                    "가만히있어요."
                ]
                
                let response = responses.randomElement() ?? "알 수 없어요."
                state.chatMessages.append(ChatMessage(
                    id: UUID(),
                    text: response,
                    isUser: false
                ))
                
                return .none
                
            case .weatherTapped:
//                state.showMenuOptions = false
//                
//                let lastWeatherCheck = userDefaultsClient.getString(UserDefaultsKey.lastDateWeatherChecked)
//                let formatter = DateFormatter()
//                formatter.dateFormat = "yyyy-MM-dd"
//                let today = formatter.string(from: Date())
//                
//                if lastWeatherCheck != today || userDefaultsClient.getData(UserDefaultsKey.cachedWeatherData) == nil {
//                    return .run { send in
//                        do {
//                            let location = try await locationService.getCurrentLocation()
//                            let weather = try await weatherService.fetchWeather(location: location)
//                            
//                            if let weather = weather,
//                               let weatherData = try? JSONEncoder().encode(weather) {
//                                userDefaultsClient.setData(UserDefaultsKey.cachedWeatherData, weatherData)
//                                userDefaultsClient.setString(UserDefaultsKey.lastDateWeatherChecked, today)
//                                await send(.didFetchWeather(weather))
//                            } else {
//                                await send(.showWeatherErrorAlert("날씨 정보를 가져올 수 없습니다."))
//                            }
//                        } catch WeatherError.locationPermissionDenied {
//                            await send(.showLocationPermissionAlert)
//                        } catch WeatherError.locationTimeout, WeatherError.locationNotAvailable {
//                            await send(.showLocationPermissionAlert)
//                        } catch {
//                            await send(.showWeatherErrorAlert("네트워크 오류로 날씨 정보를 가져올 수 없습니다."))
//                        }
//                    }
//                } else {
//                    state.showWeatherInfo = true
//                }
                return .none
                
            case .clearChat:
                state.chatMessages.removeAll()
                state.showMenuOptions = false
                return .none
                
            case .didFetchSchedules(let schedules):
                let today = Calendar.current.startOfDay(for: Date())
                let todayWeekday = Calendar.current.component(.weekday, from: today)
                let todaySchedules = schedules.filter {
                    Calendar.current.isDate($0.date, inSameDayAs: today) ||
                    ($0.isWeeklyRepeat && Calendar.current.component(.weekday, from: $0.date) == todayWeekday)
                }
                .sorted {
                    let time1 = Calendar.current.dateComponents([.hour, .minute], from: $0.date)
                    let time2 = Calendar.current.dateComponents([.hour, .minute], from: $1.date)
                    return time1.hour! * 60 + time1.minute! < time2.hour! * 60 + time2.minute!
                }
                
                state.todaySchedules = todaySchedules
                
                return .none
                
            case .didFetchDDays(let ddays):
                let storedSortType = storage.get(.ddaySortType, defaultValue: DDaySortType.dateAsc.rawValue)
                if let sortType = DDaySortType(rawValue: storedSortType) {
                    state.todayDDays = sortDDays(ddays, by: sortType)
                } else {
                    state.todayDDays = ddays
                }
                return .none
                
            case .didFetchWeather(let weather):
                state.currentWeather = weather
                if weather != nil {
                    state.showWeatherInfo = true
                }
                return .none
                
            case .showLocationPermissionAlert:
                state.showLocationAlert = true
                state.alertMessage = "위치 권한이 필요합니다."
                return .none
                
            case .showWeatherErrorAlert(let message):
                state.showWeatherAlert = true
                state.alertMessage = message
                return .none
                
            case .dismissAlert:
                state.showLocationAlert = false
                state.showWeatherAlert = false
                state.alertMessage = ""
                return .none
            }
        }
    }
    
    private func sortDDays(_ ddays: [DDay], by sortType: DDaySortType) -> [DDay] {
        switch sortType {
        case .titleAsc:
            return ddays.sorted { $0.title < $1.title }
        case .titleDesc:
            return ddays.sorted { $0.title > $1.title }
        case .dateAsc:
            return ddays.sorted { $0.date < $1.date }
        case .dateDesc:
            return ddays.sorted { $0.date > $1.date }
        case .ddayAsc:
            return ddays.sorted {
                $0.daysCalculate() < $1.daysCalculate()
            }
        case .ddayDesc:
            return ddays.sorted {
                $0.daysCalculate() > $1.daysCalculate()
            }
        }
    }
}
