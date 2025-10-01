import Foundation
//import WeatherKit
//import CoreLocation
import Domain

//public class LiveWeatherService: WeatherServiceProtocol {
//    private let weatherService = WeatherService()
//    
//    public init() {}
//    
//    public func fetchWeather(location: CLLocation) async throws -> Domain.WeatherInfo? {
//        do {
//            let weather = try await weatherService.weather(for: location)
//            
//            let dailyForecast = weather.dailyForecast.first
//            let minTemp = dailyForecast?.lowTemperature.value ?? 0
//            let maxTemp = dailyForecast?.highTemperature.value ?? 0
//            
//            let condition = translateCondition(weather.currentWeather.condition)
//            
//            return WeatherInfo(
//                minTemp: minTemp,
//                maxTemp: maxTemp,
//                condition: condition
//            )
//        } catch {
//            print("Weather fetch error: \(error)")
//            throw error
//        }
//    }
//    
//    private func translateCondition(_ condition: WeatherCondition) -> String {
//        switch condition {
//        case .clear:
//            return "맑은"
//        case .mostlyClear:
//            return "대체로 맑은"
//        case .partlyCloudy:
//            return "구름 조금 있는"
//        case .mostlyCloudy:
//            return "대체로 흐린"
//        case .cloudy:
//            return "흐린"
//        case .foggy:
//            return "안개가 낀"
//        case .haze:
//            return "연무가 있는"
//        case .windy:
//            return "바람이 부는"
//        case .breezy:
//            return "산들바람이 부는"
//        case .drizzle:
//            return "이슬비가 내리는"
//        case .heavyRain:
//            return "폭우가 내리는"
//        case .rain:
//            return "비가 오는"
//        case .snow:
//            return "눈이 오는"
//        case .sleet:
//            return "진눈깨비가 내리는"
//        case .hail:
//            return "우박이 내리는"
//        case .thunderstorms:
//            return "뇌우가 있는"
//        case .blizzard:
//            return "눈보라가 치는"
//        case .blowingDust:
//            return "먼지가 날리는"
//        case .blowingSnow:
//            return "눈보라가 부는"
//        case .flurries:
//            return "눈발이 날리는"
//        case .freezingDrizzle:
//            return "언 이슬비가 내리는"
//        case .freezingRain:
//            return "언 비가 내리는"
//        case .frigid:
//            return "매우 추운"
//        case .heavySnow:
//            return "폭설이 내리는"
//        case .hot:
//            return "매우 더운"
//        case .hurricane:
//            return "허리케인이 있는"
//        case .isolatedThunderstorms:
//            return "국지성 뇌우가 있는"
//        case .scatteredThunderstorms:
//            return "산발적 뇌우가 있는"
//        case .smoky:
//            return "연기가 자욱한"
//        case .strongStorms:
//            return "강한 폭풍이 있는"
//        case .sunFlurries:
//            return "햇빛과 눈발이 있는"
//        case .sunShowers:
//            return "햇빛과 소나기가 있는"
//        case .tropicalStorm:
//            return "열대성 폭풍이 있는"
//        case .wintryMix:
//            return "눈과 비가 섞인"
//        @unknown default:
//            return "변화무쌍한"
//        }
//    }
//}
