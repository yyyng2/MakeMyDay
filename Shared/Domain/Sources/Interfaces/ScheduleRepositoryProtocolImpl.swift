import Foundation
import SwiftData

@MainActor
public protocol ScheduleRepositoryProtocol {
    func fetchAllSchedules() throws -> [Schedule]
    func fetchSchedules(forDate date: Date) throws -> [Schedule]
    func searchSchedules(byTitle title: String) throws -> [Schedule]
    func addSchedule(_ schedule: Schedule) throws
    func updateSchedule(_ schedule: Schedule) throws
    func deleteScheduleById(_ id: UUID) throws
}
