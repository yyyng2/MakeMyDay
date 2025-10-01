import Foundation
import SwiftData
import Domain

@MainActor
public class DDayRepository: DDayRepositoryProtocol {
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
        do {
             let allDDays = try fetchAllDDays()
             
             if let existingDDay = allDDays.first(where: { $0.id == dday.id }) {
                 existingDDay.title = dday.title
                 existingDDay.date = dday.date
                 existingDDay.isAnniversary = dday.isAnniversary
                 existingDDay.dayPlus = dday.dayPlus

                 try modelContainer.mainContext.save()
             } else {
                 throw NSError(domain: "DDayRepository", code: 404, userInfo: [NSLocalizedDescriptionKey: "DDay not found"])
             }
         } catch {
             throw error
         }
    }
    
    public func deleteDDayById(_ id: UUID) throws {
        do {
            let allDDays = try fetchAllDDays()
            
            if let ddayToDelete = allDDays.first(where: { $0.id == id }) {
                modelContainer.mainContext.delete(ddayToDelete)
                try modelContainer.mainContext.save()
            } else {
                throw NSError(domain: "DDayRepository", code: 404, userInfo: [NSLocalizedDescriptionKey: "DDay not found with id: \(id)"])
            }
        } catch {
            throw error
        }
    }
}
