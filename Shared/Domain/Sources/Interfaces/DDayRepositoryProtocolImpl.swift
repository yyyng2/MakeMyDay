import Foundation
import SwiftData

@MainActor
public protocol DDayRepositoryProtocol {
    func fetchAllDDays() throws -> [DDay]
    func addDDay(_ dday: DDay) throws
    func updateDDay(_ dday: DDay) throws
    func deleteDDayById(_ id: UUID) throws
}
