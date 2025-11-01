import Foundation
import SwiftData
import Domain

@MainActor
public class ScheduleRepository: ScheduleRepositoryImpl {
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
        do {
             let allSchedules = try fetchAllSchedules()
             
             if let existingSchedule = allSchedules.first(where: { $0.id == schedule.id }) {
                 existingSchedule.title = schedule.title
                 existingSchedule.date = schedule.date
                 existingSchedule.isWeeklyRepeat = schedule.isWeeklyRepeat
                 existingSchedule.showInCalendar = schedule.showInCalendar

                 try modelContainer.mainContext.save()
             } else {
                 throw NSError(domain: "ScheduleRepository", code: 404, userInfo: [NSLocalizedDescriptionKey: "Schedule not found"])
             }
         } catch {
             throw error
         }
    }
    
    public func deleteScheduleById(_ id: UUID) throws {
        do {
            let allSchedules = try fetchAllSchedules()
            
            if let scheduleToDelete = allSchedules.first(where: { $0.id == id }) {
                modelContainer.mainContext.delete(scheduleToDelete)
                try modelContainer.mainContext.save()
            } else {
                throw NSError(domain: "ScheduleRepository", code: 404, userInfo: [NSLocalizedDescriptionKey: "Schedule not found with id: \(id)"])
            }
        } catch {
            throw error
        }
    }
}
