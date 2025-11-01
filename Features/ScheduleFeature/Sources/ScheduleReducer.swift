import Foundation
import Core
import Domain
import ComposableArchitecture

@Reducer
public struct ScheduleReducer {
    @ObservableState
    public struct State: Equatable {
        public var schedules: [Schedule]
        public var isLoading: Bool
        public var editingSchedule: Schedule?
        public var isEditSheetPresented: Bool = false
        public var selectedDate: Date = Date()
        public var currentYearMonth: Date = Date()
        
        public var isSearchPresented: Bool = false
        public var searchText: String = ""
        public var searchResults: [Schedule] = []
        
        public init(
            schedules: [Schedule] = [],
            isLoading: Bool = false,
            editingSchedule: Schedule? = nil,
            isEditSheetPresented: Bool = false,
            selectedDate: Date = Date(),
            currentYearMonth: Date = Date(),
            isSearchPresented: Bool = false,
            searchText: String = "",
            searchResults: [Schedule] = []
        ) {
            self.schedules = schedules
            self.isLoading = isLoading
            self.editingSchedule = editingSchedule
            self.isEditSheetPresented = isEditSheetPresented
            self.selectedDate = selectedDate
            self.currentYearMonth = currentYearMonth
            self.isSearchPresented = isSearchPresented
            self.searchText = searchText
            self.searchResults = searchResults
        }
    }
    
    public enum Action {
        case onAppear
        case didFetchSchedules([Schedule])
        case deleteSchedule(Schedule)
        case editScheduleTapped(Schedule?)
        case setEditSheet(isPresented: Bool)
        case saveSchedule(Schedule)
        case dateSelected(Date)
        case previousMonth
        case nextMonth
        case previousYear
        case nextYear
        case searchButtonTapped
        case setSearchPresented(Bool)
        case searchTextChanged(String)
        case didSearchSchedules([Schedule])
        case searchResultSelected(Schedule)
    }
    
    @Dependency(\.scheduleRepository) var scheduleRepository: ScheduleRepositoryProtocol
    @Dependency(\.appStorageRepository) var storage
    
    public init() {}
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.isLoading = true
                
                return .run { [scheduleRepository] send in
                    await MainActor.run {
                        do {
                            let schedules = try scheduleRepository.fetchAllSchedules()
                            send(.didFetchSchedules(schedules))
                        } catch {
                            
                        }
                    }
                }
                
            case .editScheduleTapped(let schedule):
                state.editingSchedule = schedule ?? Schedule(
                    id: UUID(),
                    title: "",
                    date: state.selectedDate,
                    isWeeklyRepeat: false,
                    showInCalendar: true
                )
                state.isEditSheetPresented = true
                return .none
                
            case .setEditSheet(isPresented: let isPresented):
                state.isEditSheetPresented = isPresented
                return .none
                
            case .saveSchedule(let schedule):
                let scheduleId = schedule.id
                let scheduleTitle = schedule.title
                let scheduleDate = schedule.date
                let scheduleIsWeekRepeat = schedule.isWeeklyRepeat
                let scheduleShowInCalendar = schedule.showInCalendar
                
                return .run { [scheduleRepository, state] send in
                    do {
                        let newSchedule = Schedule(
                            id: scheduleId,
                            title: scheduleTitle,
                            date: scheduleDate,
                            isWeeklyRepeat: scheduleIsWeekRepeat,
                            showInCalendar: scheduleShowInCalendar
                        )
                        
                        if state.schedules.contains(where: { $0.id == scheduleId }) {
                            try await scheduleRepository.updateSchedule(newSchedule)
                        } else {
                            try await scheduleRepository.addSchedule(newSchedule)
                        }
                        await send(.onAppear)
                        await send(.setEditSheet(isPresented: false))
                    } catch {
                        
                    }
                }
            case .didFetchSchedules(let scheduleList):
                state.schedules = scheduleList
                return .none
            case .deleteSchedule(let schedule):
                let scheduleId = schedule.id
                return .run { [scheduleRepository] send in
                    do {
                        try await scheduleRepository.deleteScheduleById(scheduleId)
                        await send(.onAppear)
                    } catch {
                        
                    }
                }
                
            case .dateSelected(let date):
                state.selectedDate = date
                return .none
                
            case .previousMonth:
                state.currentYearMonth = Calendar.current.date(byAdding: .month, value: -1, to: state.currentYearMonth) ?? state.currentYearMonth
                return .none
                
            case .nextMonth:
                state.currentYearMonth = Calendar.current.date(byAdding: .month, value: 1, to: state.currentYearMonth) ?? state.currentYearMonth
                return .none
                
            case .previousYear:
                state.currentYearMonth = Calendar.current.date(byAdding: .year, value: -1, to: state.currentYearMonth) ?? state.currentYearMonth
                return .none
                
            case .nextYear:
                state.currentYearMonth = Calendar.current.date(byAdding: .year, value: 1, to: state.currentYearMonth) ?? state.currentYearMonth
                return .none
                
            case .searchButtonTapped:
                state.isSearchPresented = true
                return .none
                
            case .setSearchPresented(let isPresented):
                state.isSearchPresented = isPresented
                if !isPresented {
                    state.searchText = ""
                    state.searchResults = []
                }
                return .none
                
            case .searchTextChanged(let text):
                state.searchText = text
                if text.isEmpty {
                    state.searchResults = []
                    return .none
                } else {
                    return .run { [scheduleRepository] send in
                        await MainActor.run {
                            do {
                                let results = try scheduleRepository.searchSchedules(byTitle: text)
                                send(.didSearchSchedules(results))
                            } catch {
                                // 에러 처리
                            }
                        }
                    }
                }
                
            case .didSearchSchedules(let results):
                state.searchResults = results
                return .none
                
            case .searchResultSelected(let schedule):
                state.isSearchPresented = false
                state.searchText = ""
                state.searchResults = []
                return .send(.editScheduleTapped(schedule))
            }
        }
    }
}
