import Foundation
import SwiftData
import Domain

@MainActor
public class ScheduleRepositoryImpl: ScheduleRepository {
    public let modelContainer: ModelContainer
    
    public init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
    }
    
    public func fetchAllSchedules() throws -> [Schedule] {
        let descriptor = FetchDescriptor<Schedule>(sortBy: [SortDescriptor(\.date)])
        return try modelContainer.mainContext.fetch(descriptor)
    }
    
    public func fetchSchedules(forDate date: Date) throws -> [Schedule] {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let predicate = #Predicate<Schedule> {
            $0.date >= startOfDay && $0.date < endOfDay
        }
        
        let descriptor = FetchDescriptor<Schedule>(
            predicate: predicate,
            sortBy: [SortDescriptor(\.date)]
        )
        
        return try modelContainer.mainContext.fetch(descriptor)
    }
    
    public func searchSchedules(byTitle title: String) throws -> [Schedule] {
        let predicate = #Predicate<Schedule> { schedule in
            schedule.title.localizedStandardContains(title)
        }
        
        let descriptor = FetchDescriptor<Schedule>(
            predicate: predicate,
            sortBy: [SortDescriptor(\.date)]
        )
        
        return try modelContainer.mainContext.fetch(descriptor)
    }
    
    public func addSchedule(_ schedule: Schedule) throws {
        modelContainer.mainContext.insert(schedule)
        try modelContainer.mainContext.save()
    }
    
    public func updateSchedule(_ schedule: Schedule) throws {
        let allSchedules = try fetchAllSchedules()
        
        guard let existingSchedule = allSchedules.first(where: { $0.id == schedule.id }) else {
            throw ErrorType.notFound(id: schedule.id)
        }
        
        existingSchedule.title = schedule.title
        existingSchedule.date = schedule.date
        existingSchedule.isWeeklyRepeat = schedule.isWeeklyRepeat
        existingSchedule.showInCalendar = schedule.showInCalendar
        
        do {
            try modelContainer.mainContext.save()
        } catch {
            throw ErrorType.saveFailed(underlying: error)
        }
    }
    
    public func deleteScheduleById(_ id: UUID) throws {
        let allSchedules = try fetchAllSchedules()
        
        guard let scheduleToDelete = allSchedules.first(where: { $0.id == id }) else {
            throw ErrorType.notFound(id: id)
        }
        
        modelContainer.mainContext.delete(scheduleToDelete)
        
        do {
            try modelContainer.mainContext.save()
        } catch {
            throw ErrorType.saveFailed(underlying: error)
        }
    }
}
