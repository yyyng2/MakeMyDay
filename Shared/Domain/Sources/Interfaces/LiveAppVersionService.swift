import Foundation

public protocol AppVersionService {
    func getUpdateURL() -> URL?
    var isLatestVersion: @Sendable () async -> Bool { get }
}
