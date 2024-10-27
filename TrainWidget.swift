//
//  TrainWidget.swift
//  TrainWidget
//
//  Created by Ivan Wang on 10/27/24.
//

import WidgetKit
import SwiftUI
import CoreLocation
import Foundation

let sharedDefaults = UserDefaults(suiteName: "group.com.yourcompany.trainwidget")

struct SimpleEntry: TimelineEntry {
    let date: Date
    let name1: String
    let name2: String
    let time1: String
    let time2: String
    let name3: String
}

struct TrainSchedule {
    let schedDepDate: String
    let destination: String
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(
            date: Date(),
            name1: "Loading...",
            name2: "Loading...",
            time1: "--",
            time2: "--",
            name3: "Loading..."
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(
            date: Date(),
            name1: "Snapshot Name1",
            name2: "Snapshot Name2",
            time1: "Snapshot Time1",
            time2: "Snapshot Time2",
            name3: "Snapshot Station"
        )
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        // Fetch the closest station name from UserDefaults
        let sharedDefaults = UserDefaults(suiteName: "group.com.yourcompany.trainwidget")
        let stationName = sharedDefaults?.string(forKey: "ClosestStation") ?? "New Brunswick"

        // Create a date for the next update
        let currentDate = Date()
        let nextUpdateDate = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)!

        // Fetch train data and create the timeline entry
        fetchTrainData(for: stationName) { entry in
            let timeline = Timeline(entries: [entry], policy: .after(nextUpdateDate))
            completion(timeline)
        }
    }

    func fetchTrainData(for stationName: String, completion: @escaping (SimpleEntry) -> Void) {
        fetchTrainSchedule(for: stationName) { schedules in
            var name1 = "N/A"
            var name2 = "N/A"
            var time1 = "--"
            var time2 = "--"

            if let schedules = schedules {
                if let firstSchedule = schedules.first {
                    name1 = firstSchedule.destination
                    if let minutesTillArrival = timeTillTrainArrival(for: firstSchedule) {
                        time1 = "\(minutesTillArrival) mins"
                    }
                }

                if schedules.count > 1 {
                    let secondSchedule = schedules[1]
                    name2 = secondSchedule.destination
                    if let minutesTillArrival = timeTillTrainArrival(for: secondSchedule) {
                        time2 = "\(minutesTillArrival) mins"
                    }
                }
            }

            let entry = SimpleEntry(
                date: Date(),
                name1: name1,
                name2: name2,
                time1: time1,
                time2: time2,
                name3: stationName
            )
            completion(entry)
        }
    }
}

struct TrainWidgetEntryView: View {
    var entry: SimpleEntry

    var body: some View {
        GeometryReader { geometry in
            let widgetWidth = geometry.size.width
            let widgetHeight = geometry.size.height

            VStack {
                // Title
                Text("New Brunswick")
                    .font(.system(size: widgetHeight * 0.11, weight: .bold, design: .default))
                    .lineLimit(1)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, minHeight: widgetHeight * 0.12)
                    .padding(.bottom, widgetHeight * 0.05)
                VStack(spacing: widgetHeight * 0.1) {
                    // First Train Box
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.black.opacity(0.9))
                            .shadow(radius: 5)

                        VStack {
                            HStack(spacing: 2){
                                Text("to")
                                    .foregroundColor(.red)
                                    .font(.system(size: widgetHeight * 0.08, weight: .bold))
                                Text("New York -SEC")
                                    .font(.system(size: widgetHeight * 0.08, weight: .bold))
                                    .foregroundColor(.white)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .frame(height: widgetHeight * 0.1)
                            }

                            HStack(spacing: 0) {
                                Image(systemName: "arrow.right")
                                    .font(.system(size: widgetHeight * 0.1, weight: .bold))
                                    .foregroundColor(.white)

                                Text("21 mins")
                                    .font(.system(size: widgetHeight * 0.1, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.leading, 4)
                            }
                        }
                        .padding(widgetHeight * 0.02)
                    }
                    .frame(width: widgetWidth * 0.9, height: widgetHeight * 0.25)

                    // Second Train Box
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.black.opacity(0.9))
                            .shadow(radius: 5)

                        VStack {
                            HStack(spacing: 2){
                                Text("to")
                                    .foregroundColor(.red)
                                    .font(.system(size: widgetHeight * 0.08, weight: .bold))
                                Text("Trenton")
                                    .font(.system(size: widgetHeight * 0.08, weight: .bold))
                                    .foregroundColor(.white)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .frame(height: widgetHeight * 0.1)
                            }

                            HStack(spacing: 0) {
                                Image(systemName: "arrow.right")
                                    .font(.system(size: widgetHeight * 0.1, weight: .bold))
                                    .foregroundColor(.white)

                                Text("11 mins")
                                    .font(.system(size: widgetHeight * 0.1, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.leading, 4)
                            }
                        }
                        .padding(widgetHeight * 0.02)
                    }
                    .frame(width: widgetWidth * 0.9, height: widgetHeight * 0.25)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .containerBackground(.fill.tertiary, for: .widget)
    }
}



struct TrainWidget: Widget {
    let kind: String = "TrainWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TrainWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Train Time Widget")
        .description("Shows train times.")
    }
}

func getStationSchedule(token: String, stationName: String, completion: @Sendable @escaping (String?, String?) -> Void) {
    let urlString = "https://testraildata.njtransit.com/api/TrainData/getStationSchedule"
    guard let url = URL(string: urlString) else {
        completion(nil, nil)
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    let boundary = UUID().uuidString
    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

    let parameters = [
        "token": token,
        "station": stationName,
        "NJTOnly": "false"
    ]

    var body = ""
    for (key, value) in parameters {
        body += "--\(boundary)\r\n"
        body += "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n"
        body += "\(value)\r\n"
    }
    body += "--\(boundary)--\r\n"
    
    request.httpBody = body.data(using: .utf8)

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            completion(nil, nil)
            return
        }

        // Decode JSON response
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
               let firstItem = json.first,
               let items = firstItem["ITEMS"] as? [[String: Any]],
               let schedDepDate = items.first?["SCHED_DEP_DATE"] as? String,
               let destination = items.first?["DESTINATION"] as? String {
                completion(schedDepDate, destination)
            } else {
                completion(nil, nil)
            }
        } catch {
            completion(nil, nil)
        }
    }

    task.resume()
}

func fetchTrainSchedule(for stationName: String, completion: @escaping ([TrainSchedule]?) -> Void) {
    let token = "638656244378754855"
    let url = URL(string: "https://testraildata.njtransit.com/api/TrainData/getStationSchedule")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"

    let boundary = UUID().uuidString
    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    var body = "--\(boundary)\r\n"
    body += "Content-Disposition: form-data; name=\"token\"\r\n\r\n"
    body += "\(token)\r\n"
    body += "--\(boundary)\r\n"
    body += "Content-Disposition: form-data; name=\"station\"\r\n\r\n"
    body += "\(stationName)\r\n"
    body += "--\(boundary)--\r\n"

    request.httpBody = body.data(using: .utf8)

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("API request failed: \(error.localizedDescription)")
            completion(nil)
            return
        }

        guard let data = data else {
            print("No data received")
            completion(nil)
            return
        }

        do {
            if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let items = jsonResponse["ITEMS"] as? [[String: Any]] {

                var schedules: [TrainSchedule] = []
                for item in items {
                    if let schedDepDate = item["SCHED_DEP_DATE"] as? String,
                       let destination = item["DESTINATION"] as? String {
                        let schedule = TrainSchedule(schedDepDate: schedDepDate, destination: destination)
                        schedules.append(schedule)
                    }
                }

                DispatchQueue.main.async {
                    completion(schedules)
                }
            } else {
                print("Invalid response format")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        } catch {
            print("Failed to parse JSON: \(error)")
            DispatchQueue.main.async {
                completion(nil)
            }
        }
    }
    task.resume()
}

func calculateMinuteDifference(from dateString: String) -> Int? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    dateFormatter.timeZone = TimeZone.current // Adjust if necessary

    guard let inputDate = dateFormatter.date(from: dateString) else {
        print("Invalid date string")
        return nil
    }
    let currentDate = Date()
    let minuteDifference = Calendar.current.dateComponents([.minute], from: currentDate, to: inputDate).minute
    return minuteDifference
}

func timeTillTrainArrival(for schedule: TrainSchedule) -> Int? {
    if let minutesTillArrival = calculateMinuteDifference(from: schedule.schedDepDate) {
        return minutesTillArrival
    } else {
        print("Failed to calculate time till train arrival")
        return nil
    }
}


func getName1(for stationName: String, completion: @escaping (String?) -> Void) {
    fetchTrainSchedule(for: stationName) { schedules in
        guard let schedules = schedules, !schedules.isEmpty else {
            completion(nil)
            return
        }
        let destination = schedules[0].destination
        completion(destination)
    }
}

func getTime1(for stationName: String, completion: @escaping (String?) -> Void) {
    fetchTrainSchedule(for: stationName) { schedules in
        guard let schedules = schedules, !schedules.isEmpty else {
            completion(nil)
            return
        }
        if let minutesTillArrival = timeTillTrainArrival(for: schedules[0]) {
            completion("\(minutesTillArrival) mins")
        } else {
            completion(nil)
        }
    }
}

func getName2(for stationName: String, completion: @escaping (String?) -> Void) {
    fetchTrainSchedule(for: stationName) { schedules in
        guard let schedules = schedules, schedules.count > 1 else {
            completion(nil)
            return
        }
        let destination = schedules[1].destination
        completion(destination)
    }
}

func getTime2(for stationName: String, completion: @escaping (String?) -> Void) {
    fetchTrainSchedule(for: stationName) { schedules in
        guard let schedules = schedules, schedules.count > 1 else {
            completion(nil)
            return
        }
        if let minutesTillArrival = timeTillTrainArrival(for: schedules[1]) {
            completion("\(minutesTillArrival) mins")
        } else {
            completion(nil)
        }
    }
}
