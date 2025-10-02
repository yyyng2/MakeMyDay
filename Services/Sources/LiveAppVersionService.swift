import Foundation
import Domain

public struct LiveAppVersionService: AppVersionServiceProtocol {
    public init() {}
    
    public func getUpdateURL() -> URL? {
        return URL(string: "https://apps.apple.com/app/make-my-day/id1645004491")
    }
    
    public var isLatestVersion: @Sendable () async -> Bool {
        return {
            guard let url = URL(string: "https://itunes.apple.com/lookup?id=1645004491") else { return true }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                guard
                    let response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let results = response["results"] as? [[String: Any]],
                    let appVersion = results.first?["version"] as? String,
                    let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
                else {
                    return true
                }
                
                return isCurrentVersionLatest(current: currentVersion, appStore: appVersion)
            } catch {
                return true
            }
        }
    }
    
    private func isCurrentVersionLatest(current: String, appStore: String) -> Bool {
        let currentVersion = current.split(separator: ".").compactMap { Int($0) }
        let appStoreVersion = appStore.split(separator: ".").compactMap { Int($0) }
        
        let maxLength = max(currentVersion.count, appStoreVersion.count)
        let paddedCurrent = currentVersion + Array(repeating: 0, count: maxLength - currentVersion.count)
        let paddedAppStore = appStoreVersion + Array(repeating: 0, count: maxLength - appStoreVersion.count)

        for (current, appStore) in zip(paddedCurrent, paddedAppStore) {
            if current < appStore {
                return false
            } else if current > appStore {
                return true
            }
        }
        
        return true
    }
}
