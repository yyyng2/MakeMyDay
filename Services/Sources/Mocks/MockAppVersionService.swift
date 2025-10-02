import Foundation
import Domain

public struct MockAppVersionService: AppVersionServiceProtocol {
    public init() {}
    
    public func getUpdateURL() -> URL? {
        return nil
    }
    
    public var isLatestVersion: @Sendable () async -> Bool {
        return { return true }
    }
}
