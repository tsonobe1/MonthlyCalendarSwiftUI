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
}
