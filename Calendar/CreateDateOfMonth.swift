//
//  CreateDateOfMonth.swift
//  Calendar
//
//  Created by tsonobe on 2023/10/11.
//

import Foundation

// 月の初日から末日までのDateを生成する関数
func generateDatesOfMonth(for selectedMonth: Date) -> [Date]? {
    let calendar = Calendar.current
    
    guard
        // selectedMonthの年と月のうちの、初日を取得
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: selectedMonth)),
        // startOfMonthの1ヶ月後の1秒前を取得
        let endOfMonth = calendar.date(byAdding: .month, value: 1, to: startOfMonth)?.addingTimeInterval(-1)
    else {
        return nil
    }
    
    var dates: [Date] = []
    var currentDate = startOfMonth
    // currentDateがendOfMonthに追いつくまで、currentDateを加算しながら配列に追加する
    while currentDate <= endOfMonth {
        dates.append(currentDate)
        
        if let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate) {
            currentDate = nextDate
        } else {
            break
        }
    }
    
    return dates
}
