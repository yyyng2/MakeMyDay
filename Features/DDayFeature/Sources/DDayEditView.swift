import SwiftUI
import Domain
import UIComponents
import Utilities
import ComposableArchitecture

public struct DDayEditView: View {
    @State private var title: String
    @State private var date: Date
    @State private var isAnniversary: Bool
    @State private var dayPlus: Bool
    @State private var showDatePicker: Bool = false
    @FocusState private var isTitleFocused: Bool
    @Dependency(\.localeService) var localeService
    @Dependency(\.colorProvider) var colorProvider
    
    private let dday: DDay
    private let onSave: (DDay) -> Void
    private let onCancel: () -> Void
    
    public init(
        dday: DDay,
        onSave: @escaping (DDay) -> Void,
        onCancel: @escaping () -> Void
    ) {
        self.dday = dday
        self.onSave = onSave
        self.onCancel = onCancel
        
        self._title = State(initialValue: dday.title)
        self._date = State(initialValue: dday.date)
        self._isAnniversary = State(initialValue: dday.isAnniversary)
        self._dayPlus = State(initialValue: dday.dayPlus)
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
                            Text(localeService.localized(forKey: .commonDate))
                            Spacer()
                            Text(date.formattedYyyyMmDd())
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                Section(header: Text(localeService.localized(forKey: .commonOptions))) {
                    Toggle(localeService.localized(forKey: .ddayIsAnniversary) + localeService.localized(forKey: .ddayIsAnniversaryInfomation), isOn: $isAnniversary)
                        .toggleStyle(SwitchToggleStyle(tint: .mint))
                    
                    if !isAnniversary {
                        Toggle(localeService.localized(forKey: .ddayCountingDayOne), isOn: $dayPlus)
                            .toggleStyle(SwitchToggleStyle(tint: .mint))
                    }
                }
                
                Section {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("D-Day" + localeService.localized(forKey: .commonPreview))
                            .font(.headline)
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(title.isEmpty ? localeService.localized(forKey: .commonTitlePlaceholder) : title)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(title.isEmpty ? .secondary : .primary)
                                
                                HStack(spacing: 16) {
                                    HStack(spacing: 4) {
                                        Image(systemName: "calendar")
                                            .foregroundColor(.accentColor)
                                            .font(.caption)
                                        Text(
                                            isAnniversary
                                            ? date.getNextAnniversaryCount() + " " + date.formattedMmDdWithWeekday()
                                            : date.formattedYyyyMmDdWithWeekday()
                                        )
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Spacer()
                                    
                                    ZStack {
                                        Circle()
                                            .stroke(colorProvider.color(asset: .AccentColor).opacity(0.3), lineWidth: 3)
                                            .frame(width: 70, height: 70)
                                        
                                        VStack(spacing: 2) {
                                            let impDday = DDay(title: "", date: date, isAnniversary: isAnniversary, dayPlus: dayPlus)
                                            let daysCalculated = impDday.daysCalculate()
                                            if daysCalculated == 0 {
                                                Text("D-DAY")
                                                    .font(.caption2)
                                                    .fontWeight(.bold)
                                            } else {
                                                Text(daysCalculated < 0 ? "D-" : "D+")
                                                    .font(.caption2)
                                                    .fontWeight(.medium)
                                                Text("\(abs(daysCalculated))")
                                                    .font(.title2)
                                                    .fontWeight(.bold)
                                            }
                                        }
                                        .foregroundColor(colorProvider.color(asset: .AccentColor))
                                    }
                                }
                                
                                HStack(spacing: 8) {
                                    if isAnniversary {
                                        Label(localeService.localized(forKey: .ddayIsAnniversary), systemImage: "repeat.circle.fill")
                                            .font(.caption2)
                                            .foregroundColor(.green)
                                            .padding(.horizontal, 6)
                                            .padding(.vertical, 2)
                                            .background(Color.green.opacity(0.2))
                                            .clipShape(.capsule)
                                    }
                                    
                                    if !isAnniversary && dayPlus {
                                        Label("Day+1", systemImage: "plus.circle.fill")
                                            .font(.caption2)
                                            .foregroundColor(.orange)
                                            .padding(.horizontal, 6)
                                            .padding(.vertical, 2)
                                            .background(Color.orange.opacity(0.2))
                                            .clipShape(.capsule)
                                    }
                                }
                            }
                            
                            Spacer()
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .clipShape(.rect(cornerRadius: 12))
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
            .navigationTitle(dday.title == "" ? "D-Day " + localeService.localized(forKey: .commonAdd) : "D-Day " + localeService.localized(forKey: .commonEdit))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(localeService.localized(forKey: .commonCancel)) {
                        onCancel()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(localeService.localized(forKey: .commonSave)) {
                        let updatedDDay = DDay(
                            id: dday.id,
                            title: title,
                            date: date,
                            isAnniversary: isAnniversary,
                            dayPlus: isAnniversary ? false : dayPlus
                        )
                        onSave(updatedDDay)
                    }
                    .disabled(title.isEmpty)
                }
            }
            .overlay {
                if showDatePicker {
                    DatePickerView(
                        date: $date,
                        showTime: false,
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
