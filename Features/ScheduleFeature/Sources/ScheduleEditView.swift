import SwiftUI
import Domain
import UIComponents
import Utilities
import Resources

public struct ScheduleEditView: View {
    @State private var title: String
    @State private var date: Date
    @State private var isWeeklyRepeat: Bool
    @State private var showInCalendar: Bool
    @State private var showDatePicker: Bool = false
    @FocusState private var isTitleFocused: Bool
    
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
                Section(header: Text("common_infomation".localized())) {
                    TextField("common_title".localized(), text: $title)
                        .focused($isTitleFocused)
                    
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            showDatePicker = true
                        }
                    }) {
                        HStack {
                            Text("schedule_date".localized())
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
                
                Section(header: Text("common_options".localized())) {
                    Toggle("schedule_repeatOption".localized(), isOn: $isWeeklyRepeat)
                        .toggleStyle(SwitchToggleStyle(tint: .mint))
                    Toggle("schedule_calendarOption".localized(), isOn: $showInCalendar)
                        .toggleStyle(SwitchToggleStyle(tint: .mint))
                }
                
                Section {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("schedule_unit".localized() + " " + "common_preview".localized())
                            .font(.headline)
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(title.isEmpty ? "common_titlePlaceholder".localized() : title)
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
                                        Text("schedule_calendarOption".localized())
                                            .font(.caption2)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                
                                HStack {
                                    if isWeeklyRepeat {
                                        Label("schedule_repeatOption".localized(), systemImage: "repeat")
                                            .font(.caption2)
                                            .foregroundColor(.orange)
                                            .padding(.horizontal, 6)
                                            .padding(.vertical, 2)
                                            .background(Color.orange.opacity(0.2))
                                            .clipShape(.capsule)
                                    }
                                    
                                    if showInCalendar {
                                        Label("schedule_calendarOption".localized(), systemImage: "calendar.badge.plus")
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
            .navigationTitle(schedule.title == "" ? "\("schedule_unit".localized()) \("common_add".localized())" : "\("schedule_unit".localized()) \("common_edit".localized())")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("common_cancel".localized()) {
                        onCancel()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("common_save".localized()) {
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
                        }
                    )
                    .padding()
                }
            }
        }
    }
}
