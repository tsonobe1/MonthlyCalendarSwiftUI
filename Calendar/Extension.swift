//
//  Extension.swift
//  Calendar
//
//  Created by tsonobe on 2023/10/11.
//

import Foundation

extension Date {
    // 曜日を数値で返す 日:1 ... 土:6
    func getWeekDay() -> Int {
        return Calendar.current.component(.weekday, from: self) - 1
    }
    
    var firstDayOfNextMonth: Date? {
        let calendar = Calendar.current
        if let nextMonth = calendar.date(byAdding: .month, value: 1, to: self) {
            return calendar.date(from: calendar.dateComponents([.year, .month], from: nextMonth))
        }
        return nil
    }
    
    var lastDayOfPreviousMonth: Date? {
        let calendar = Calendar.current
        if let firstDayOfCurrentMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: self)),
           let lastDayOfPreviousMonth = calendar.date(byAdding: .day, value: -1, to: firstDayOfCurrentMonth) {
            return lastDayOfPreviousMonth
        }
        return nil
    }
}


extension DateFormatter {
    // 1
    static var dayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }
    
    // 2023
    static var yearFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }
    
    // Jan
    static var monthFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter
    }
    
    // Tue
    static var weekdayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }
    
    // 12/31/23
    static var shortDateForm: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    // 12:00
    static var shortTimeForm: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }
     
    // 02/28
    static var nonZeroDayMonthForm: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/d"
        return formatter
    }
    
    // 02/28
    static var dayMonthForm: DateFormatter {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("MM/dd")
        return formatter
    }
}
