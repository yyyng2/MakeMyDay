//
//  MMDWidget.swift
//  MMDWidget
//
//  Created by Y on 2022/12/16.
//

import WidgetKit
import SwiftUI
import Intents

import RealmSwift

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 1 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct MMDWidgetEntryView : View {
    var entry: Provider.Entry

    @Environment(\.widgetFamily) private var widgetFamily
    
    let data = DdayRepository.shared.fetchFilterPinned()
//    let filterData = DdayRepository.shared.fetchRange()
    
    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            VStack {
                Text("\("todayTodoCount".localized) \(ScheduleRepository.shared.scheduleCount())")
                    .minimumScaleFactor(0.001)
                    .padding(4)
                ForEach(data, id: \.self) { i in
                    HStack {
                        switch i.dayPlus {
                        case true:
                            Spacer()
                            Text("\(i.title)")
                                .lineLimit(1)
                                .minimumScaleFactor(0.001)
                            Spacer()
                                .minimumScaleFactor(0.001)
                            Text("\(DdayRepository.shared.days(string: i.dateString))\("day".localized)")
                                .minimumScaleFactor(0.001)
                            Spacer()
                                .minimumScaleFactor(0.001)
                        case false:
                            Spacer()
                            Text("\(i.title)")
                                .lineLimit(1)
                                .minimumScaleFactor(0.001)
                            Spacer()
                                .minimumScaleFactor(0.001)
                            Text("\(DdayRepository.shared.days(string: i.dateString) - 1)\("day".localized)")
                                .minimumScaleFactor(0.001)
                            Spacer()
                                .minimumScaleFactor(0.001)
                        }
                    }
                }
            }
        case .systemMedium:
            VStack {
                Text("\("todayTodoCount".localized) \(ScheduleRepository.shared.scheduleCount())")
                    .padding(4)
                    .minimumScaleFactor(0.001)
                ForEach(data, id: \.self) { i in
                    HStack {
                        switch i.dayPlus {
                        case true:
                            Spacer()
                                .minimumScaleFactor(0.001)
                            Text("\(i.title)")
                                .lineLimit(1)
                                .minimumScaleFactor(0.001)
                            Spacer()
                                .minimumScaleFactor(0.001)
                            Text("\(DdayRepository.shared.days(string: i.dateString))\("day".localized)")
                                .minimumScaleFactor(0.001)
                            Spacer()
                                .minimumScaleFactor(0.001)
                        case false:
                            Spacer()
                                .minimumScaleFactor(0.001)
                            Text("\(i.title)")
                                .lineLimit(1)
                            Spacer()
                                .minimumScaleFactor(0.001)
                            Text("\(DdayRepository.shared.days(string: i.dateString) - 1)\("day".localized)")
                            Spacer()
                                .minimumScaleFactor(0.001)
                        }
                    }
                }
            }
        case .systemLarge:
            VStack {
                Text("\("todayTodoCount".localized) \(ScheduleRepository.shared.scheduleCount())")
                    .padding()
                    .minimumScaleFactor(0.001)
                ForEach(data, id: \.self) { i in
                    HStack {
                        switch i.dayPlus {
                        case true:
                            Text("\(i.title)")
                                .lineLimit(1)
                                .minimumScaleFactor(0.001)
                            Spacer()
                                .minimumScaleFactor(0.001)
                            Text("\(DdayRepository.shared.days(string: i.dateString))\("day".localized)")
                                .minimumScaleFactor(0.001)
                        case false:
                            Text("\(i.title)")
                                .lineLimit(1)
                                .minimumScaleFactor(0.001)
                            Spacer()
                                .minimumScaleFactor(0.001)
                            Text("\(DdayRepository.shared.days(string: i.dateString) - 1)\("day".localized)")
                                .minimumScaleFactor(0.001)
                        }
                    }
                    .padding()
                    .minimumScaleFactor(0.001)
                }
            }
        case .systemExtraLarge:
            VStack {
                Text("\("todayTodoCount".localized) \(ScheduleRepository.shared.scheduleCount())")
                    .padding()
                    .minimumScaleFactor(0.001)
                ForEach(data, id: \.self) { i in
                    HStack {
                        switch i.dayPlus {
                        case true:
                            Text("\(i.title)")
                                .lineLimit(1)
                                .minimumScaleFactor(0.001)
                            Spacer()
                                .minimumScaleFactor(0.001)
                            Text("\(DdayRepository.shared.days(string: i.dateString))\("day".localized)")
                                .minimumScaleFactor(0.001)
                        case false:
                            Text("\(i.title)")
                                .lineLimit(1)
                                .minimumScaleFactor(0.001)
                            Spacer()
                                .minimumScaleFactor(0.001)
                            Text("\(DdayRepository.shared.days(string: i.dateString) - 1)\("day".localized)")
                                .minimumScaleFactor(0.001)
                        }
                    }
                    .padding()
                    .minimumScaleFactor(0.001)
                }
            }
        case .accessoryCircular:
            VStack {
                Image("day_white")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                HStack {
                    Text("\(ScheduleRepository.shared.scheduleCount())")
                        .minimumScaleFactor(0.001)
                }
            }
        case .accessoryRectangular:
            VStack {
                ForEach(data, id: \.self) { i in
                    HStack {
                        switch i.dayPlus {
                        case true:
                            Spacer()
                                .minimumScaleFactor(0.001)
                            Text("\(i.title)")
                                .lineLimit(1)
                                .minimumScaleFactor(0.001)
                            Spacer()
                                .minimumScaleFactor(0.001)
                            Text("\(DdayRepository.shared.days(string: i.dateString))\("day".localized)")
                                .minimumScaleFactor(0.001)
                            Spacer()
                        case false:
                            Spacer()
                                .minimumScaleFactor(0.001)
                            Text("\(i.title)")
                                .lineLimit(1)
                                .minimumScaleFactor(0.001)
                            Spacer()
                                .minimumScaleFactor(0.001)
                            Text("\(DdayRepository.shared.days(string: i.dateString) - 1)\("day".localized)")
                                .minimumScaleFactor(0.001)
                            Spacer()
                                .minimumScaleFactor(0.001)
                        }
                    }
                }
            }
        case .accessoryInline:
            VStack {
                Text("\("todayTodoCount".localized) \(ScheduleRepository.shared.scheduleCount())")
                    .minimumScaleFactor(0.001)
            }
        @unknown default:
            Text("unknown")
        }
    }
}

struct MMDWidget: Widget {
    let kind: String = "MMDWidget"

    private let supportedFamilies:[WidgetFamily] = {
        if #available(iOSApplicationExtension 16.0, *) {
            return [.systemSmall, .systemMedium, .systemLarge, .accessoryCircular, .accessoryRectangular, .accessoryInline]
        } else {
            return [.systemSmall, .systemMedium, .systemLarge]
        }
    }()

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            MMDWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("MakeMyDay Widget")
        .description("")
        .supportedFamilies(supportedFamilies)
    }
}

struct MMDWidget_Previews: PreviewProvider {
    static var previews: some View {
        MMDWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

final class ScheduleRepository {
    
    static let shared: ScheduleRepository = .init()
    
    var localRealm: Realm {
       let container = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.io.github.yyyng2.MakeMyDay")
       let realmURL = container?.appendingPathComponent("default.realm")
       let config = Realm.Configuration(fileURL: realmURL, schemaVersion: 0)
       do {
           return try Realm(configuration: config)
       } catch let error as NSError {
           print("error \(error.debugDescription)")
           fatalError("Can't continue further, no Realm available")
       }
   }
    
    func scheduleCount() -> Int {
        let today = dateFormatToString(date: Date())
        
        let scheduleTasks = localRealm.objects(Schedule.self).filter("dateString CONTAINS[c] '\(today)'")

        return scheduleTasks.count
    }
    
    func getCount() -> Int {
        let realmUserData = localRealm.objects(Schedule.self)
        
        return  realmUserData.count
    }
   

    func fetch() -> Results<Schedule> {
        
        return localRealm.objects(Schedule.self).sorted(byKeyPath: "date", ascending: true)
      
    }
    
    func fetchFilterDate(date: Date) -> Results<Schedule> {
        return localRealm.objects(Schedule.self).filter("date == %@", date).sorted(byKeyPath: "date", ascending: true)
    }
    
    func fetchFilterDateString(formatString: String) -> Results<Schedule> {
        return localRealm.objects(Schedule.self).filter("dateString CONTAINS[c] '\(formatString)'").sorted(byKeyPath: "date", ascending: true)
    }
    
    enum FormatStyle {
        case yyyyMMddEaHHmm
        case yyyyMMdd
        case yyyy
        case MM
        case dd
        case hhmm
    }
    
    func dateFormatToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale.current
     
        dateFormatter.dateFormat = "yyyy-MM-dd"
     
        let string = dateFormatter.string(from: date)
        return string
    }
    
}

final class DdayRepository {
    
    static let shared: DdayRepository = .init()
    
     var localRealm: Realm {
        let container = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.io.github.yyyng2.MakeMyDay")
        let realmURL = container?.appendingPathComponent("default.realm")
        let config = Realm.Configuration(fileURL: realmURL, schemaVersion: 0)
        do {
            return try Realm(configuration: config)
        } catch let error as NSError {
            print("error \(error.debugDescription)")
            fatalError("Can't continue further, no Realm available")
        }
    }

    func fetch() -> Results<Dday> {
        
        return localRealm.objects(Dday.self).sorted(byKeyPath: "date", ascending: true)
      
    }
    
    func fetchFilterDateString(formatDate: String) -> Results<Dday> {
        return localRealm.objects(Dday.self).filter("dateString CONTAINS[c] '\(formatDate)'").sorted(byKeyPath: "date", ascending: false)
    }
    
    func fetchFilterDate(date: Date) -> Results<Dday> {
        return localRealm.objects(Dday.self).filter("date == %@", date).sorted(byKeyPath: "date", ascending: false)
    }
    
    func fetchFilter(text: String) -> Results<Dday> {
        return localRealm.objects(Dday.self).filter("title CONTAINS[c] '\(text)'").sorted(byKeyPath: "date", ascending: false)
    }
    
    func fetchFilterPinned() -> Results<Dday> {
        return localRealm.objects(Dday.self).filter("pin == true").sorted(byKeyPath: "date", ascending: false)
    }
    
    func fetchRange() -> [Dday] {
        let data = localRealm.objects(Dday.self).filter("pin == true").sorted(byKeyPath: "date", ascending: false)
        var filter: [Dday] = []
        if data.count > 3 {
            for i in data[0..<3] {
                filter.append(i)
            }
        } else {
            for i in data {
                filter.append(i)
            }
        }
        return filter
    }
    
    enum FormatStyle {
        case yyyyMMddEaHHmm
        case yyyyMMdd
        case yyyy
        case MM
        case dd
        case hhmm
    }
    
    func localDate(date: Date, formatStyle: FormatStyle) -> Date? {
        
        let date = date
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale.current
        
        switch formatStyle {
        case .yyyyMMddEaHHmm:
           dateFormatter.dateFormat = "yyyy-MM-dd (E) a hh:mm"
        case .yyyyMMdd:
            dateFormatter.dateFormat = "yyyy-MM-dd"
        case .yyyy:
            dateFormatter.dateFormat = "yyyy"
        case .MM:
            dateFormatter.dateFormat = "MM"
        case .dd:
            dateFormatter.dateFormat = "dd"
        case .hhmm:
            dateFormatter.dateFormat = "a hh:mm"
        }
        
        let string = dateFormatter.string(from: date)
        let today = dateFormatter.date(from: string)
        
        return today
    }
    
    func stringFormatToDate(string: String, formatStyle: FormatStyle) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale.current
        switch formatStyle {
        case .yyyyMMddEaHHmm:
           dateFormatter.dateFormat = "yyyy-MM-dd (E) a hh:mm"
        case .yyyyMMdd:
            dateFormatter.dateFormat = "yyyy-MM-dd"
        case .yyyy:
            dateFormatter.dateFormat = "yyyy"
        case .MM:
            dateFormatter.dateFormat = "MM"
        case .dd:
            dateFormatter.dateFormat = "dd"
        case .hhmm:
            dateFormatter.dateFormat = "a hh:mm"
        }
        
        let date = dateFormatter.date(from: string)
        return date
    }
    //D-day 계산
    func days(string: String) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale.current
     
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        
        guard let date = dateFormatter.date(from: string) else { return 0 }
        
        let calendar = Calendar.current
        let currentDate = localDate(date: Date(), formatStyle: .yyyyMMdd)
        return calendar.dateComponents([.day], from: date, to: currentDate!).day! + 1
    }
    
}
