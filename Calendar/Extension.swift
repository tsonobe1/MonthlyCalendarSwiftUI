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
        // weekdayプロパティは、1 が日曜日を、2 が月曜日を、...、7 が土曜日を表す値を返す
        // 日曜日を0にしたいので、 -1 にした値を返している
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
    
    // 11月
    static var monthFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter
    }

    // 2023/12/31
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
