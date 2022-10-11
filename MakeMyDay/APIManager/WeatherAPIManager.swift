//
//  WeatherAPIManager.swift
//  MakeMyDay
//
//  Created by Y on 2022/10/11.
//

import Foundation


    // 에러 정의
enum NetworkError: Error {
        case badUrl
        case noData
        case decodingError
}
    
class WeatherAPIManager {
        
        func getWeather(lat: Double, lon: Double, completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
            
            // API 호출을 위한 URL
            let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&&appid=\(APIKey.openWeather)")
            guard let url = url else {
                return completion(.failure(.badUrl))
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    return completion(.failure(.noData))
                }
                
                // Data 타입으로 받은 리턴을 디코드
                let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)
                
                // 성공
                if let weatherResponse = weatherResponse {
                    print(weatherResponse)
                    completion(.success(weatherResponse)) // 성공한 데이터 저장
                } else {
                    completion(.failure(.decodingError))
                }
            }.resume() // 이 dataTask 시작
        }
}

