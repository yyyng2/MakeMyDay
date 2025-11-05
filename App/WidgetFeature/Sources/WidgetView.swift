//
//  Widget.swift
//  WidgetFeature
//
//  Created by Y on 10/24/25.
//  Copyright © 2025 MakeMyDay. All rights reserved.
//

import SwiftUI
import WidgetKit
import AppIntents
import Domain
import Data
import Utilities
import Resources

enum WidgetDisplayType: String, AppEnum {
    case ddayWithSchedule = "widget_ddayWithSchedule"
    case ddayOnly = "widget_ddayOnly"
    case scheduleOnly = "widget_scheduleOnly"
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "widget_displayType"
    static var caseDisplayRepresentations: [WidgetDisplayType: DisplayRepresentation] = [
        .ddayWithSchedule: "widget_ddayWithSchedule",
        .ddayOnly: "widget_ddayOnly",
        .scheduleOnly: "widget_scheduleOnly"
    ]
}

struct DDayEntity: AppEntity {
    var id: String
    var title: String
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "D-Day"
    
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(title)")
    }
    
    static var defaultQuery = DDayQuery()
}

struct DDayQuery: EntityQuery {
    func entities(for identifiers: [String]) async throws -> [DDayEntity] {
        let modelContainer = ModelContainerClientImpl.create(schemas: [DDay.self, Schedule.self])
        let repository = await DDayRepositoryImpl(modelContainer: modelContainer)
        let allDDays = try await repository.fetchAllDDays()
        
        return allDDays
            .filter { identifiers.contains($0.id.uuidString) }
            .map { DDayEntity(id: $0.id.uuidString, title: $0.title) }
    }
    
    func suggestedEntities() async throws -> [DDayEntity] {
        let modelContainer = ModelContainerClientImpl.create(schemas: [DDay.self, Schedule.self])
        let repository = await DDayRepositoryImpl(modelContainer: modelContainer)
        let allDDays = try await repository.fetchAllDDays()
        
        return allDDays.map { DDayEntity(id: $0.id.uuidString, title: $0.title) }
    }
}

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = LocalizedStringResource("widget_displaySettings")
    static var description = IntentDescription("widget_displayContents")
    
    @Parameter(title: "widget_displayType")
    var displayType: WidgetDisplayType
    
    @Parameter(title: "widget_ddaySelect")
    var selectedDDays: [DDayEntity]?
    
    init() {
        self.displayType = .ddayWithSchedule
    }
    
    init(displayType: WidgetDisplayType, selectedDDays: [DDayEntity]?) {
        self.displayType = displayType
        self.selectedDDays = selectedDDays
    }
}

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }
    
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        return Timeline(entries: [entry], policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct MMDWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) private var widgetFamily
    
    let modelContainer = ModelContainerClientImpl.create(schemas: [DDay.self, Schedule.self])
    
    var ddayRepository: DDayRepository {
        DDayRepositoryImpl(modelContainer: modelContainer)
    }
    
    var scheduleRepository: ScheduleRepository {
        ScheduleRepositoryImpl(modelContainer: modelContainer)
    }
    
    var ddays: [DDay] {
        let allDDays = (try? ddayRepository.fetchAllDDays()) ?? []
        
        guard let selectedIds = entry.configuration.selectedDDays?.map({ $0.id }),
              !selectedIds.isEmpty else {
            let maxCount = getMaxDDayCount()
            return Array(allDDays.prefix(maxCount))
        }
        
        let filtered = allDDays.filter { selectedIds.contains($0.id.uuidString) }
        let maxCount = getMaxDDayCount()
        return Array(filtered.prefix(maxCount))
    }
    
    private func getMaxDDayCount() -> Int {
        switch widgetFamily {
        case .systemLarge: return 10
        default: return 5
        }
    }
    
    var todayScheduleCount: Int {
        let today = Calendar.current.startOfDay(for: Date())
        let todayWeekday = Calendar.current.component(.weekday, from: today)
        
        return (try? scheduleRepository.fetchAllSchedules().filter {
            Calendar.current.isDate($0.date, inSameDayAs: today) ||
            ($0.isWeeklyRepeat && Calendar.current.component(.weekday, from: $0.date) == todayWeekday)
        }.count) ?? 0
    }
    
    var todaySchedules: [Schedule] {
        guard entry.configuration.displayType == .scheduleOnly else { return [] }
        let now = Date()
        let today = Calendar.current.startOfDay(for: now)
        let todayWeekday = Calendar.current.component(.weekday, from: today)
        let allSchedules = (try? scheduleRepository.fetchAllSchedules()) ?? []
        
        let todaySchedules = allSchedules.filter {
            Calendar.current.isDate($0.date, inSameDayAs: today) ||
            ($0.isWeeklyRepeat && Calendar.current.component(.weekday, from: $0.date) == todayWeekday)
        }
        
        let nowTime = Calendar.current.dateComponents([.hour, .minute, .second], from: now)
        
        let futureSchedules = todaySchedules.filter { schedule in
            let scheduleTime = Calendar.current.dateComponents([.hour, .minute, .second], from: schedule.date)
            return scheduleTime.hour! > nowTime.hour! ||
            (scheduleTime.hour! == nowTime.hour! && scheduleTime.minute! >= nowTime.minute!)
        }
            .sorted {
                let time1 = Calendar.current.dateComponents([.hour, .minute], from: $0.date)
                let time2 = Calendar.current.dateComponents([.hour, .minute], from: $1.date)
                return time1.hour! * 60 + time1.minute! < time2.hour! * 60 + time2.minute!
            }
        
        let maxCount = getMaxDDayCount()
        
        if futureSchedules.count >= maxCount {
            return Array(futureSchedules.prefix(maxCount))
        }
        
        let needed = maxCount - futureSchedules.count
        let pastSchedules = todaySchedules.filter { $0.date < now }
            .sorted {
                let time1 = Calendar.current.dateComponents([.hour, .minute], from: $0.date)
                let time2 = Calendar.current.dateComponents([.hour, .minute], from: $1.date)
                return time1.hour! * 60 + time1.minute! < time2.hour! * 60 + time2.minute!
            }
        
        return Array(pastSchedules.suffix(needed)) + futureSchedules
    }
    
    var body: some View {
        let displayType = entry.configuration.displayType
        
        switch widgetFamily {
        case .systemSmall:
            SmallWidgetView(
                ddays: ddays,
                scheduleCount: todayScheduleCount,
                schedules: todaySchedules,
                displayType: displayType
            )
        case .systemMedium:
            MediumWidgetView(
                ddays: ddays,
                scheduleCount: todayScheduleCount,
                schedules: todaySchedules,
                displayType: displayType
            )
        case .systemLarge:
            LargeWidgetView(
                ddays: ddays,
                scheduleCount: todayScheduleCount,
                schedules: todaySchedules,
                displayType: displayType
            )
            //        case .systemExtraLarge:
            
        case .accessoryCircular:
            CircularWidgetView(scheduleCount: todayScheduleCount)
        case .accessoryRectangular:
            RectangularWidgetView(ddays: Array(ddays.prefix(3)))
        case .accessoryInline:
            InlineWidgetView(scheduleCount: todayScheduleCount)
            
        @unknown default:
            Text("unknown")
        }
    }
}

struct SmallWidgetView: View {
    let ddays: [DDay]
    let scheduleCount: Int
    let schedules: [Schedule]
    let displayType: WidgetDisplayType
    
    var body: some View {
        VStack {
            Spacer(minLength: 1)
            
            HStack(alignment: .center) {
                Spacer()
                Image(uiImage: ResourcesAsset.Assets.dIcon.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
                
                if displayType != .ddayOnly {
                    Spacer()
                    HStack {
                        Text("widget_todaySchedules".localized())
                            .minimumScaleFactor(0.001)
                            .lineLimit(1)
                            .font(.system(size: 16))
                        Spacer()
                        Text("\(scheduleCount)")
                            .minimumScaleFactor(0.001)
                            .lineLimit(1)
                            .font(.system(size: 16))
                        Spacer()
                    }
                }
                Spacer()
            }
            .frame(maxHeight: 16, alignment: .topLeading)
            
            Spacer()
            Divider()
            Spacer()
            
            if displayType == .scheduleOnly {
                ForEach(schedules.prefix(5), id: \.id) { schedule in
                    HStack {
                        Spacer(minLength: 1)
                        Text("\(schedule.title)")
                            .lineLimit(1)
                            .minimumScaleFactor(0.001)
                            .font(.system(size: 12))
                        Spacer()
                        Text(schedule.date.formatTime())
                            .minimumScaleFactor(0.001)
                            .font(.system(size: 12))
                        Spacer(minLength: 1)
                    }
                    Spacer()
                }
            } else {
                ForEach(ddays.prefix(5), id: \.id) { i in
                    HStack {
                        Spacer(minLength: 1)
                        Text("\(i.title)")
                            .lineLimit(1)
                            .minimumScaleFactor(0.001)
                            .font(.system(size: 12))
                        Spacer()
                        Spacer()
                        Text("D\(i.daysCalculate().formattedDDay())")
                            .minimumScaleFactor(0.001)
                            .font(.system(size: 12))
                        Spacer(minLength: 1)
                    }
                    Spacer()
                }
            }
        }
    }
}

struct MediumWidgetView: View {
    let ddays: [DDay]
    let scheduleCount: Int
    let schedules: [Schedule]
    let displayType: WidgetDisplayType
    
    var body: some View {
        VStack {
            Spacer(minLength: 1)
            
            HStack(alignment: .center) {
                Spacer()
                Image(uiImage: ResourcesAsset.Assets.dIcon.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
                
                if displayType != .ddayOnly {
                    Spacer()
                    Text("widget_todaySchedules".localized())
                        .minimumScaleFactor(0.001)
                        .lineLimit(1)
                        .font(.system(size: 16))
                    Spacer()
                    Text("\(scheduleCount)")
                        .minimumScaleFactor(0.001)
                        .lineLimit(1)
                        .font(.system(size: 16))
                }
                Spacer()
            }
            .frame(maxHeight: 16, alignment: .topLeading)
            
            Spacer()
            Divider()
            Spacer()
            
            if displayType == .scheduleOnly {
                ForEach(schedules.prefix(5), id: \.id) { schedule in
                    HStack {
                        Spacer(minLength: 1)
                        Text("\(schedule.title)")
                            .lineLimit(1)
                            .minimumScaleFactor(0.001)
                            .font(.system(size: 12))
                        Spacer()
                        Text(schedule.date.formatTime())
                            .minimumScaleFactor(0.001)
                            .font(.system(size: 12))
                        Spacer(minLength: 1)
                    }
                    Spacer()
                }
            } else {
                ForEach(ddays.prefix(5), id: \.id) { i in
                    HStack {
                        Spacer(minLength: 1)
                        Text("\(i.title)")
                            .lineLimit(1)
                            .minimumScaleFactor(0.001)
                            .font(.system(size: 12))
                        Spacer()
                        Spacer()
                        Text("D\(i.daysCalculate().formattedDDay())")
                            .minimumScaleFactor(0.001)
                            .font(.system(size: 12))
                        Spacer(minLength: 1)
                    }
                    Spacer()
                }
            }
        }
    }
}

struct LargeWidgetView: View {
    let ddays: [DDay]
    let scheduleCount: Int
    let schedules: [Schedule]
    let displayType: WidgetDisplayType
    
    var body: some View {
        VStack {
            Spacer(minLength: 1)
            
            HStack(alignment: .center) {
                Spacer()
                Image(uiImage: ResourcesAsset.Assets.dIcon.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                
                if displayType != .ddayOnly {
                    Spacer()
                    Text("widget_todaySchedules".localized())
                        .minimumScaleFactor(0.001)
                        .lineLimit(1)
                        .font(.system(size: 30))
                    Spacer()
                    Text("\(scheduleCount)")
                        .minimumScaleFactor(0.001)
                        .lineLimit(1)
                        .font(.system(size: 30))
                }
                Spacer()
            }
            .frame(maxHeight: 30, alignment: .topLeading)
            
            Spacer()
            Divider()
            Spacer()
            
            if displayType == .scheduleOnly {
                ForEach(schedules.prefix(10), id: \.id) { schedule in
                    HStack {
                        Spacer(minLength: 1)
                        Text("\(schedule.title)")
                            .lineLimit(1)
                            .minimumScaleFactor(0.001)
                        Spacer()
                        Text(schedule.date.formatTime())
                            .minimumScaleFactor(0.001)
                        Spacer(minLength: 1)
                    }
                    Spacer()
                }
            } else {
                ForEach(ddays.prefix(10), id: \.id) { i in
                    HStack {
                        Spacer(minLength: 1)
                        Text("\(i.title)")
                            .lineLimit(1)
                            .minimumScaleFactor(0.001)
                        Spacer()
                        Spacer()
                        Text("D\(i.daysCalculate().formattedDDay())")
                            .minimumScaleFactor(0.001)
                        Spacer(minLength: 1)
                    }
                    Spacer()
                }
            }
        }
    }
}

struct CircularWidgetView: View {
    let scheduleCount: Int
    
    var body: some View {
        VStack {
            //            Image(uiImage: ResourcesAsset.Assets.dIcon.image)
            //                .resizable()
            //                .aspectRatio(contentMode: .fit)
            Text("widget_schedulesForCircularWidgetView".localized())
            HStack {
                Text("\(scheduleCount)")
                    .minimumScaleFactor(0.001)
            }
        }
    }
}

struct RectangularWidgetView: View {
    let ddays: [DDay]
    
    var body: some View {
        VStack {
            ForEach(ddays, id: \.id) { i in
                HStack {
                    Spacer()
                        .minimumScaleFactor(0.001)
                    Text("\(i.title)")
                        .lineLimit(1)
                        .minimumScaleFactor(0.001)
                    Spacer()
                        .minimumScaleFactor(0.001)
                    Text("D\(i.daysCalculate().formattedDDay())")
                        .minimumScaleFactor(0.001)
                    Spacer()
                }
            }
        }
    }
}

struct InlineWidgetView: View {
    let scheduleCount: Int
    
    var body: some View {
        VStack {
            Text("widget_todaySchedules".localized()+" \(scheduleCount)")
                .minimumScaleFactor(0.001)
        }
    }
}

struct MMDWidget: Widget {
    let kind: String = "MMDWidget"
    
    private let supportedFamilies: [WidgetFamily] = [
        .systemSmall,
        .systemMedium,
        .systemLarge,
        .accessoryCircular,
        .accessoryRectangular,
        .accessoryInline
    ]
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: ConfigurationAppIntent.self,
            provider: Provider()
        ) { entry in
            MMDWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("widget_title")
        .description("widget_selectWidget")
        .supportedFamilies(supportedFamilies)
    }
}
