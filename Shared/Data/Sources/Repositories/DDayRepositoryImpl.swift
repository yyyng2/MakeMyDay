import Foundation
import SwiftData
import Domain

@MainActor
public class DDayRepositoryImpl: DDayRepository {
    public let modelContainer: ModelContainer
    
    public init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
    }
    
    public func fetchAllDDays() throws -> [DDay] {
        let descriptor = FetchDescriptor<DDay>(sortBy: [SortDescriptor(\.date)])
        return try modelContainer.mainContext.fetch(descriptor)
    }
    
    public func addDDay(_ dday: DDay) throws {
        modelContainer.mainContext.insert(dday)
        try modelContainer.mainContext.save()
    }
    
    public func updateDDay(_ dday: DDay) throws {
        let allDDays = try fetchAllDDays()
        
        guard let existingDDay = allDDays.first(where: { $0.id == dday.id }) else {
            throw ErrorType.notFound(id: dday.id)
        }
        
        existingDDay.title = dday.title
        existingDDay.date = dday.date
        existingDDay.isAnniversary = dday.isAnniversary
        existingDDay.dayPlus = dday.dayPlus
        
        do {
            try modelContainer.mainContext.save()
        } catch {
            throw ErrorType.saveFailed(underlying: error)
        }
    }
    
    public func deleteDDayById(_ id: UUID) throws {
        let allDDays = try fetchAllDDays()
        
        guard let ddayToDelete = allDDays.first(where: { $0.id == id }) else {
            throw ErrorType.notFound(id: id)
        }
        
        modelContainer.mainContext.delete(ddayToDelete)
        
        do {
            try modelContainer.mainContext.save()
        } catch {
            throw ErrorType.saveFailed(underlying: error)
        }
    }
}
