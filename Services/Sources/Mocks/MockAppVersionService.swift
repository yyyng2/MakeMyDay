import Foundation
import Domain

public struct MockAppVersionService: AppVersionServiceImpl {
    public init() {}
    
    public func getUpdateURL() -> URL? {
        return nil
    }
    
    public var isLatestVersion: @Sendable () async -> Bool {
        return { return true }
    }
}
