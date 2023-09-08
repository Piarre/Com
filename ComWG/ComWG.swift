//
//  ComWG.swift
//  ComWG
//
//  Created by Pierre Idé on 08/08/2023.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀")
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀")
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

struct ComWGEntryView : View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: Provider.Entry
    
    var body: some View {
        switch family {
        case .systemSmall:
            VStack {
                Image(systemName: "wave.3.right")
                Text("Scan")
            }
        case .systemMedium:
            VStack {
                Image(systemName: "wave.3.right")
                Text("Scan")
            }
        case .systemLarge:
            VStack {
                Image(systemName: "wave.3.right")
                Text("Scan")
            }
        case .systemExtraLarge:
            VStack {
                Image(systemName: "wave.3.right")
                Text("Scan")
            }
        case .accessoryCorner:
            VStack {
                Image(systemName: "wave.3.right")
                Text("Scan")
            }
        case .accessoryCircular:
            VStack {
                Image(systemName: "wave.3.right")
                Text("Scan")
            }
        case .accessoryRectangular:
            HStack {
                Image(systemName: "wave.3.right")
                Text("Scan now")
            }
            .widgetURL(ScanView.self)
        case .accessoryInline:
            VStack {
                Image(systemName: "wave.3.right")
                Text("Scan")
            }
        }
    }
}

struct ComWG: Widget {
    let kind: String = "ComWG"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ComWGEntryView(entry: entry)
                .containerBackground(.tint, for: .widget)
            
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.accessoryCircular, .accessoryRectangular])
    }
}

#Preview(as: .accessoryRectangular) {
    ComWG()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
}
