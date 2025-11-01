import Foundation

public protocol AppVersionServiceImpl {
    func getUpdateURL() -> URL?
    var isLatestVersion: @Sendable () async -> Bool { get }
}
