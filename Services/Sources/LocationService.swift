import Foundation
//import CoreLocation
import Domain

//public class LocationService: NSObject, LocationServiceProtocol {
//    private let locationManager = CLLocationManager()
//    private var locationContinuation: CheckedContinuation<CLLocation, Error>?
//    private var permissionContinuation: CheckedContinuation<Void, Error>?
//    private var timeoutTask: Task<Void, Never>?
//    
//    public override init() {
//        super.init()
//        setupLocationManager()
//    }
//    
//    private func setupLocationManager() {
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 더 정확한 위치
//        locationManager.distanceFilter = kCLDistanceFilterNone
//    }
//    
//    public func requestLocationPermission() async throws {
//        let authStatus = locationManager.authorizationStatus
//        
//        switch authStatus {
//        case .notDetermined:
//            try await withCheckedThrowingContinuation { continuation in
//                self.permissionContinuation = continuation
//                DispatchQueue.main.async {
//                    self.locationManager.requestWhenInUseAuthorization()
//                }
//            }
//        case .restricted, .denied:
//            throw WeatherError.locationPermissionDenied
//        case .authorizedAlways, .authorizedWhenInUse:
//            return
//        @unknown default:
//            throw WeatherError.locationPermissionDenied
//        }
//    }
//    
//    public func getCurrentLocation() async throws -> CLLocation {
//        // 위치 서비스 활성화 확인
//        guard CLLocationManager.locationServicesEnabled() else {
//            throw WeatherError.locationServicesDisabled
//        }
//        
//        try await requestLocationPermission()
//        
//        // 즉시 사용 가능한 위치가 있는지 확인
//        if let location = locationManager.location,
//           location.timestamp.timeIntervalSinceNow > -5 { // 5초 이내의 위치만 사용
//            return location
//        }
//        
//        // 새로운 위치 요청
//        return try await withCheckedThrowingContinuation { continuation in
//            self.locationContinuation = continuation
//            
//            // 타임아웃 설정
//            self.timeoutTask = Task {
//                try? await Task.sleep(nanoseconds: 10_000_000_000) // 10초로 증가
//                if self.locationContinuation != nil {
//                    self.locationContinuation?.resume(throwing: WeatherError.locationTimeout)
//                    self.locationContinuation = nil
//                    DispatchQueue.main.async {
//                        self.locationManager.stopUpdatingLocation()
//                    }
//                }
//            }
//            
//            DispatchQueue.main.async {
//                self.locationManager.startUpdatingLocation()
//            }
//        }
//    }
//}
//
//// MARK: - CLLocationManagerDelegate
//extension LocationService: CLLocationManagerDelegate {
//    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
//        
//        // 정확도 체크 (옵션)
//        if location.horizontalAccuracy < 0 {
//            return // 유효하지 않은 위치
//        }
//        
//        // continuation이 있을 때만 처리
//        if let continuation = locationContinuation {
//            timeoutTask?.cancel()
//            continuation.resume(returning: location)
//            locationContinuation = nil
//            manager.stopUpdatingLocation()
//        }
//    }
//    
//    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        if let continuation = locationContinuation {
//            timeoutTask?.cancel()
//            
//            // 위치 오류를 적절한 도메인 오류로 변환
//            let weatherError: WeatherError
//            if let clError = error as? CLError {
//                switch clError.code {
//                case .denied:
//                    weatherError = .locationPermissionDenied
//                case .locationUnknown:
//                    weatherError = .locationUnknown
//                default:
//                    weatherError = .locationError(error)
//                }
//            } else {
//                weatherError = .locationError(error)
//            }
//            
//            continuation.resume(throwing: weatherError)
//            locationContinuation = nil
//        }
//    }
//    
//    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        let status = manager.authorizationStatus
//        
//        switch status {
//        case .authorizedWhenInUse, .authorizedAlways:
//            permissionContinuation?.resume()
//            permissionContinuation = nil
//        case .denied, .restricted:
//            permissionContinuation?.resume(throwing: WeatherError.locationPermissionDenied)
//            permissionContinuation = nil
//        case .notDetermined:
//            break
//        @unknown default:
//            permissionContinuation?.resume(throwing: WeatherError.locationPermissionDenied)
//            permissionContinuation = nil
//        }
//    }
//}
