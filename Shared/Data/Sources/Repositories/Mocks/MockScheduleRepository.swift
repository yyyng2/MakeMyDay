import Foundation
import Domain

@MainActor
public class MockScheduleRepository: ScheduleRepositoryImpl {
    public var schedules: [Schedule] = []
    
    public init() {}
    
    public func fetchAllSchedules() throws -> [Schedule] {
        return schedules
    }
    
    public func fetchSchedules(forDate date: Date) throws -> [Schedule] {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        return schedules.filter { schedule in
            let scheduleDate = schedule.date
            return scheduleDate >= startOfDay && scheduleDate < endOfDay
        }
    }
    
    public func searchSchedules(byTitle title: String) throws -> [Domain.Schedule] {
        return schedules.filter { schedule in
            schedule.title.localizedCaseInsensitiveContains(title)
        }
    }
    
    public func addSchedule(_ schedule: Schedule) throws {
        schedules.append(schedule)
    }
    
    public func updateSchedule(_ schedule: Schedule) throws {
        if let index = schedules.firstIndex(where: { $0.id == schedule.id }) {
            schedules[index] = schedule
        }
    }
    
    public func deleteScheduleById(_ id: UUID) throws {
        schedules.removeAll { $0.id == id }
    }
}
