import SwiftUI
import Core
import Domain
import ComposableArchitecture

@Reducer
public struct DDayReducer {
    @ObservableState
    public struct State: Equatable {
        public var ddays: [DDay]
        public var isLoading: Bool
        public var editingDDay: DDay?
        public var isEditSheetPresented: Bool = false
        public var isSortPresented: Bool = false
        
        public init(
            ddays: [DDay] = [],
            isLoading: Bool = false,
            editingDDay: DDay? = nil,
            isEditSheetPresented: Bool = false,
            isSortPresented: Bool = false
        ) {
            self.ddays = ddays
            self.isLoading = isLoading
            self.editingDDay = editingDDay
            self.isEditSheetPresented = isEditSheetPresented
            self.isSortPresented = isSortPresented
        }
    }
    
    public enum Action {
        case onAppear
        case didFetchDDays([DDay])
        case deleteDDay(DDay)
        case editDDayTapped(DDay?)
        case setEditSheet(isPresented: Bool)
        case saveDDay(DDay)
        case sortButtonTapped
        case setSortPresented(Bool)
        case sortSelected(DDaySortType)
    }
    
    @Dependency(\.ddayRepository) var ddayRepository: DDayRepositoryProtocol
    
    public init() {}
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.isLoading = true
                
                return .run { [ddayRepository] send in
                    await MainActor.run {
                        do {
                            let ddays = try ddayRepository.fetchAllDDays()
                            send(.didFetchDDays(ddays))
                        } catch {
                            
                        }
                    }
                }
                
            case .editDDayTapped(let dday):
                state.editingDDay = dday ?? DDay(id: UUID(), title: "", date: Date(), isAnniversary: false, dayPlus: true)
                state.isEditSheetPresented = true
                return .none
                
            case .setEditSheet(isPresented: let isPresented):
                state.isEditSheetPresented = isPresented
                return .none
                
            case .saveDDay(let dday):
                let ddayId = dday.id
                let ddayTitle = dday.title
                let ddayDate = dday.date
                let ddayIsAnniversary = dday.isAnniversary
                let ddayDayPlus = dday.dayPlus
                
                return .run { [ddayRepository, state] send in
                    do {
                        let newDDay = DDay(
                            id: ddayId,
                            title: ddayTitle,
                            date: ddayDate,
                            isAnniversary: ddayIsAnniversary,
                            dayPlus: ddayDayPlus
                        )
                        
                        if state.ddays.contains(where: { $0.id == ddayId }) {
                            try await ddayRepository.updateDDay(newDDay)
                        } else {
                            try await ddayRepository.addDDay(newDDay)
                        }
                        await send(.onAppear)
                        await send(.setEditSheet(isPresented: false))
                    } catch {
                        
                        
                    }
                }
            case .didFetchDDays(let ddayList):
                @AppStorage("ddaySortType") var storedSortType: String = DDaySortType.dateAsc.rawValue
                if let sortType = DDaySortType(rawValue: storedSortType) {
                    state.ddays = sortDDays(ddayList, by: sortType)
                } else {
                    state.ddays = ddayList
                }
                return .none
            case .deleteDDay(let dday):
                let ddayId = dday.id
                return .run { [ddayRepository] send in
                    do {
                        try await ddayRepository.deleteDDayById(ddayId)
                        await send(.onAppear)
                    } catch {
                        
                    }
                }
                
            case .sortButtonTapped:
                state.isSortPresented = true
                return .none
                
            case .setSortPresented(let isPresented):
                state.isSortPresented = isPresented
                return .none
                
            case .sortSelected(let sortType):
                state.isSortPresented = false
                return .run { [state] send in
                    await MainActor.run {
                        let sortedDDays = sortDDays(state.ddays, by: sortType)
                        send(.didFetchDDays(sortedDDays))
                    }
                } 
            }
            
        }
    }
    
    private func sortDDays(_ ddays: [DDay], by sortType: DDaySortType) -> [DDay] {
        switch sortType {
        case .titleAsc:
            return ddays.sorted { $0.title < $1.title }
        case .titleDesc:
            return ddays.sorted { $0.title > $1.title }
        case .dateAsc:
            return ddays.sorted { $0.date < $1.date }
        case .dateDesc:
            return ddays.sorted { $0.date > $1.date }
        case .ddayAsc:
            return ddays.sorted {
                $0.daysCalculate() < $1.daysCalculate()
            }
        case .ddayDesc:
            return ddays.sorted {
                $0.daysCalculate() > $1.daysCalculate()
            }
        }
    }
}
