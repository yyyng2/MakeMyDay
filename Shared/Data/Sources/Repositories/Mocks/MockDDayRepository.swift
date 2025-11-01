import Foundation
import Domain

@MainActor
public class MockDDayRepository: DDayRepositoryImpl {
    public var ddays: [DDay] = []
    
    public init() {}
    
    public func fetchAllDDays() throws -> [DDay] {
        return ddays
    }
    
    public func addDDay(_ dday: DDay) throws {
        ddays.append(dday)
    }
    
    public func updateDDay(_ dday: DDay) throws {
        if let index = ddays.firstIndex(where: { $0.id == dday.id }) {
            ddays[index] = dday
        }
    }
    
    public func deleteDDayById(_ id: UUID) throws {
        ddays.removeAll { $0.id == id }
    }
}
