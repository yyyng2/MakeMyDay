import Foundation

public protocol AppVersionServiceProtocol {
    func getUpdateURL() -> URL?
    var isLatestVersion: @Sendable () async -> Bool { get }
}
