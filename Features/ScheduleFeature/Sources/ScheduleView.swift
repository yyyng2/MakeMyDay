import SwiftUI
import Domain
import UIComponents
import Utilities
import Resources
import ComposableArchitecture

public struct ScheduleView: View {
    @Bindable
    var store: StoreOf<ScheduleReducer>
    @Dependency(\.appStorageRepository) var storage
    @State private var bannerAdHeight: Double = 60
    
    public init(store: StoreOf<ScheduleReducer>) {
        self.store = store
        self._bannerAdHeight = State(initialValue: self.storage.get(.bannerAdHeight, defaultValue: 60.0))
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            GeometryReader { geometry in
                ZStack {
                    NavigationStack {
                        Spacer()
                            .frame(height: bannerAdHeight == 0 ? 60 : bannerAdHeight)
                            .safeAreaInset(edge: .top) {
                                Color.clear
                                    .frame(height: 10)
                            }
                        
                        VStack(spacing: 0) {
                            Spacer()
                                .frame(height: UIDevice.current.userInterfaceIdiom == .pad ? 50 : 0)
                            
                            CalendarView(
                                currentDate: store.currentYearMonth,
                                selectedDate: store.selectedDate,
                                schedules: store.schedules,
                                onDateSelected: { date in
                                    store.send(.dateSelected(date))
                                },
                                onPreviousMonth: {
                                    store.send(.previousMonth)
                                },
                                onNextMonth: {
                                    store.send(.nextMonth)
                                },
                                onPreviousYear: {
                                    store.send(.previousYear)
                                },
                                onNextYear: {
                                    store.send(.nextYear)
                                }
                            )
                            //                            .frame(height: (geometry.size.height - bannerAdHeight) / 2)
                            .background(Color(ResourcesAsset.Assets.baseForeground.swiftUIColor))
                            .clipShape(.rect(cornerRadius: 10))
                            .padding(.horizontal, 10)
                            
                            VStack {
                                ScrollView(.vertical) {
                                    Spacer()
                                        .frame(height: 20)
                                    
                                    VStack {
                                        let selectedDateSchedules = store.schedules.filter { schedule in
                                            if Calendar.current.isDate(schedule.date, inSameDayAs: store.selectedDate) {
                                                return true
                                            }
                                            
                                            if schedule.isWeeklyRepeat {
                                                let scheduleWeekday = Calendar.current.component(.weekday, from: schedule.date)
                                                let selectedWeekday = Calendar.current.component(.weekday, from: store.selectedDate)
                                                return scheduleWeekday == selectedWeekday
                                            }
                                            return false
                                        }
                                            .sorted {
                                                let time1 = Calendar.current.dateComponents([.hour, .minute], from: $0.date)
                                                let time2 = Calendar.current.dateComponents([.hour, .minute], from: $1.date)
                                                return time1.hour! * 60 + time1.minute! < time2.hour! * 60 + time2.minute!
                                            }
                                        
                                        if selectedDateSchedules.isEmpty {
                                            Button {
                                                store.send(.editScheduleTapped(nil))
                                            } label: {
                                                VStack(alignment: .center) {
                                                    Text("schedule_empty".localized())
                                                        .font(.headline)
                                                        .lineLimit(1)
                                                    
                                                    HStack {
                                                        Text(store.selectedDate.formattedYyyyMmDdWithWeekday())
                                                            .font(.caption)
                                                            .lineLimit(1)
                                                        Text(Date().formattedTime())
                                                            .foregroundStyle(.mint)
                                                            .font(.caption)
                                                            .lineLimit(1)
                                                    }
                                                }
                                                .frame(height: 50)
                                                .frame(maxWidth: .infinity)
                                                .background(
                                                    Color(ResourcesAsset.Assets.baseForeground.swiftUIColor)
                                                )
                                                .clipShape(.rect(cornerRadius: 10))
                                            }
                                            .padding(.horizontal, 20)
                                            .padding(.bottom, 10)
                                            
                                        } else {
                                            ForEach(selectedDateSchedules, id: \.id) { item in
                                                VStack(alignment: .center) {
                                                    HStack {
                                                        Button {
                                                            store.send(.editScheduleTapped(item))
                                                        } label: {
                                                            VStack(alignment: .center) {
                                                                Text(item.title)
                                                                    .font(.headline)
                                                                    .lineLimit(1)
                                                                HStack {
                                                                    Text(item.isWeeklyRepeat ? item.date.formattedWeekday() :  item.date.formattedYyyyMmDdWithWeekday())
                                                                        .font(.caption)
                                                                        .lineLimit(1)
                                                                    Text(item.date.formattedTime())
                                                                        .foregroundStyle(.mint)
                                                                        .font(.caption)
                                                                        .lineLimit(1)
                                                                    if item.isWeeklyRepeat {
                                                                        Text("schedule_weekOption".localized())
                                                                            .foregroundStyle(.orange)
                                                                            .font(.caption2)
                                                                            .padding(.horizontal, 4)
                                                                            .background(Color.orange.opacity(0.2))
                                                                            .clipShape(.capsule)
                                                                    }
                                                                }
                                                            }
                                                            .frame(width: geometry.size.width - 40, height: 50)
                                                            .background(
                                                                Color(ResourcesAsset.Assets.baseForeground.swiftUIColor)
                                                            )
                                                            .clipShape(.rect(cornerRadius: 10))
                                                            .contextMenu {
                                                                Button {
                                                                    store.send(.deleteSchedule(item))
                                                                } label: {
                                                                    Label("common_delete".localized(), systemImage: "trash.circle")
                                                                        .tint(.red)
                                                                }
                                                            }
                                                        }
                                                    }
                                                    .frame(height: 50)
                                                    .padding(.leading, 10)
                                                    .padding(.trailing, 10)
                                                    .padding(.bottom, 10)
                                                }
                                            }
                                        }
                                    }
                                }
                                .scrollIndicators(.hidden)
                                .safeAreaInset(edge: .bottom) {
                                    Color.clear
                                        .frame(height: 0)
                                }
                                .onAppear {
                                    let storedHeight = storage.get(.bannerAdHeight, defaultValue: 60.0)
                                    if bannerAdHeight < storedHeight {
                                        bannerAdHeight = storedHeight
                                    }
                                }
                                .onChange(of: bannerAdHeight) { oldValue, newValue in
                                    storage.set(.bannerAdHeight, value: newValue)
                                }
                            }
                        }
                    }
                    .background {
                        Image(uiImage: ResourcesAsset.Assets.baseBackground.image)
                            .resizable()
                            .ignoresSafeArea()
                    }
                }
                .overlay(
                    ZStack {
                        if store.isSearchPresented {
                            Color.black.opacity(0.3)
                                .ignoresSafeArea()
                                .onTapGesture {
                                    store.send(.setSearchPresented(false))
                                }
                        }
                        
                        VStack {
                            Spacer()
                            
                            if store.isSearchPresented {
                                SearchPopupView(
                                    searchText: $store.searchText.sending(\.searchTextChanged),
                                    searchResults: store.searchResults,
                                    onResultSelected: { schedule in
                                        store.send(.searchResultSelected(schedule))
                                    },
                                    onDismiss: {
                                        store.send(.setSearchPresented(false))
                                    }
                                )
                                .padding(.bottom, 150)
                                .transition(.scale.combined(with: .opacity))
                                .animation(.easeInOut(duration: 0.2), value: store.isSearchPresented)
                            }
                            
                            Spacer()
                        }
                        
                        FloatingButtonView(
                            buttonAction: { store.send(.searchButtonTapped) },
                            buttonImageName: "magnifyingglass",
                            buttonBottomPadding: 90
                        )
                        
                        FloatingButtonView(
                            buttonAction: { store.send(.editScheduleTapped(nil)) }
                        )
                    }
                )
                .ignoresSafeArea(.keyboard)
                .sheet(isPresented: $store.isEditSheetPresented.sending(\.setEditSheet)) {
                    if let editingSchedule = store.editingSchedule {
                        ScheduleEditView(
                            schedule: editingSchedule,
                            onSave: { updatedSchedule in
                                store.send(.saveSchedule(updatedSchedule))
                            },
                            onCancel: {
                                store.send(.setEditSheet(isPresented: false))
                            }
                        )
                    } else {
                        ProgressView()
                    }
                }
            }
            .onAppear {
                store.send(.onAppear)
            }
        }
    }
}

public struct SearchPopupView: View {
    @Binding var searchText: String
    let searchResults: [Schedule]
    let onResultSelected: (Schedule) -> Void
    let onDismiss: () -> Void
    
    public var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("schedule_findTitle".localized(), text: $searchText)
                    .textFieldStyle(PlainTextFieldStyle())
                
                if !searchText.isEmpty {
                    Button(action: { searchText = "" }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
            .background(Color(ResourcesAsset.Assets.baseForeground.swiftUIColor))
            
            Divider()
            
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(searchResults, id: \.id) { schedule in
                        Button(action: { onResultSelected(schedule) }) {
                            VStack(alignment: .center) {
                                Text(schedule.title)
                                    .font(.headline)
                                    .lineLimit(1)
                                HStack {
                                    Text(schedule.date.formattedYyyyMmDdWithWeekday())
                                        .font(.caption)
                                        .lineLimit(1)
                                    Text(schedule.date.formattedTime())
                                        .foregroundStyle(.mint)
                                        .font(.caption)
                                        .lineLimit(1)
                                    if schedule.isWeeklyRepeat {
                                        Text("schedule_weekOption".localized())
                                            .foregroundStyle(.orange)
                                            .font(.caption2)
                                            .padding(.horizontal, 4)
                                            .background(Color.orange.opacity(0.2))
                                            .clipShape(.capsule)
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color(ResourcesAsset.Assets.baseForeground.swiftUIColor))
                            .clipShape(.rect(cornerRadius: 10))
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
            .frame(height: 200)
        }
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.thinMaterial)
        )
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 10)
        .frame(maxWidth: 350)
        .ignoresSafeArea(.keyboard)
    }
}
