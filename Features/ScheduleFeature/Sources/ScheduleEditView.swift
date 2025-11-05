import SwiftUI
import Domain
import UIComponents
import Utilities
import ComposableArchitecture

public struct ScheduleEditView: View {
    @State private var title: String
    @State private var date: Date
    @State private var isWeeklyRepeat: Bool
    @State private var showInCalendar: Bool
    @State private var showDatePicker: Bool = false
    @FocusState private var isTitleFocused: Bool
    @Dependency(\.localeService) var localeService
    @Dependency(\.colorProvider) var colorProvider
    
    private let schedule: Schedule
    private let onSave: (Schedule) -> Void
    private let onCancel: () -> Void
    
    public init(
        schedule: Schedule,
        onSave: @escaping (Schedule) -> Void,
        onCancel: @escaping () -> Void
    ) {
        self.schedule = schedule
        self.onSave = onSave
        self.onCancel = onCancel
        
        self._title = State(initialValue: schedule.title)
        self._date = State(initialValue: schedule.date)
        self._isWeeklyRepeat = State(initialValue: schedule.isWeeklyRepeat)
        self._showInCalendar = State(initialValue: schedule.showInCalendar)
    }
    
    public var body: some View {
        NavigationView {
            Form {
                Section(header: Text(localeService.localized(forKey: .commonInfomation))) {
                    TextField(localeService.localized(forKey: .commonTitle), text: $title)
                        .focused($isTitleFocused)
                    
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            showDatePicker = true
                        }
                    }) {
                        HStack {
                            Text(localeService.localized(forKey: .scheduleDate))
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text(date.formattedYyyyMmDd())
                                    .foregroundColor(.secondary)
                                Text(date.formattedTime())
                                    .foregroundColor(.secondary)
                                    .font(.caption)
                            }
                        }
                    }
                }
                
                Section(header: Text(localeService.localized(forKey: .commonOptions))) {
                    Toggle(localeService.localized(forKey: .scheduleRepeatOption), isOn: $isWeeklyRepeat)
                        .toggleStyle(SwitchToggleStyle(tint: .mint))
                    Toggle(localeService.localized(forKey: .scheduleCalendarOption), isOn: $showInCalendar)
                        .toggleStyle(SwitchToggleStyle(tint: .mint))
                }
                
                Section {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(localeService.localized(forKey: .scheduleUnit) + " " + localeService.localized(forKey: .commonPreview))
                            .font(.headline)
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(title.isEmpty ? localeService.localized(forKey: .commonTitlePlaceholder) : title)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(title.isEmpty ? .secondary : .primary)
                                
                                HStack {
                                    Image(systemName: "calendar")
                                        .foregroundColor(.accentColor)
                                    Text(date.formattedYyyyMmDdWithWeekday())
                                        .font(.caption)
                                    
                                    Image(systemName: "clock")
                                        .foregroundColor(.accentColor)
                                    Text(date.formattedTime())
                                        .font(.caption)
                                    
                                    VStack {
                                        Circle()
                                            .fill(showInCalendar ? Color.red : Color.gray.opacity(0.3))
                                            .frame(width: 8, height: 8)
                                        Text(localeService.localized(forKey: .scheduleCalendarOption))
                                            .font(.caption2)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                
                                HStack {
                                    if isWeeklyRepeat {
                                        Label(localeService.localized(forKey: .scheduleRepeatOption), systemImage: "repeat")
                                            .font(.caption2)
                                            .foregroundColor(.orange)
                                            .padding(.horizontal, 6)
                                            .padding(.vertical, 2)
                                            .background(Color.orange.opacity(0.2))
                                            .clipShape(.capsule)
                                    }
                                    
                                    if showInCalendar {
                                        Label(localeService.localized(forKey: .scheduleCalendarOption), systemImage: "calendar.badge.plus")
                                            .font(.caption2)
                                            .foregroundColor(.green)
                                            .padding(.horizontal, 6)
                                            .padding(.vertical, 2)
                                            .background(Color.green.opacity(0.2))
                                            .clipShape(.capsule)
                                    }
                                }
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .clipShape(.rect(cornerRadius: 10))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 5)
                }
            }
            .onChange(of: isTitleFocused, { oldValue, newValue in
                if newValue {
                    showDatePicker = false
                }
            })
            .onChange(of: showDatePicker, { oldValue, newValue in
                if newValue {
                    isTitleFocused = false
                }
            })
            .navigationTitle(schedule.title == "" ? "\(localeService.localized(forKey: .scheduleUnit)) \(localeService.localized(forKey: .commonAdd))" : "\(localeService.localized(forKey: .scheduleUnit)) \(localeService.localized(forKey: .commonEdit))")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(localeService.localized(forKey: .commonCancel)) {
                        onCancel()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(localeService.localized(forKey: .commonSave)) {
                        let updatedSchedule = Schedule(
                            id: schedule.id,
                            title: title,
                            date: date,
                            isWeeklyRepeat: isWeeklyRepeat,
                            showInCalendar: showInCalendar
                        )
                        onSave(updatedSchedule)
                    }
                    .disabled(title.isEmpty)
                }
            }
            .overlay {
                if showDatePicker {
                    DatePickerView(
                        date: $date,
                        showTime: true,
                        confirmHandler: { selectedDate in
                            withAnimation(.easeInOut(duration: 0.5)) {
                                date = selectedDate
                                showDatePicker = false
                            }
                        }, cancelHandler: {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                showDatePicker = false
                            }
                        },
                        cancelButtonString: localeService.localized(forKey: .commonCancel),
                        confirmButtonString: localeService.localized(forKey: .commonConfirm),
                        backgroundColor: colorProvider.color(asset: .baseForeground),
                    )
                    .padding()
                }
            }
        }
    }
}
