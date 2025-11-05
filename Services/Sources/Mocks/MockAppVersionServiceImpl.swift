import Foundation
import Domain

public struct MockAppVersionServiceImpl: AppVersionService {
    public init() {}
    
    public func getUpdateURL() -> URL? {
        return nil
    }
    
    public var isLatestVersion: @Sendable () async -> Bool {
        return { return true }
    }
}
