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
        // selectedMonthの年と月情報のみを抽出し、その月の初日を取得する。時刻は00:00:00に設定されている
        // selectedMonthが"2023/6/7 12:32:23"なら、2023/6/1 00:00:00を取得
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: selectedMonth)),
        // startOfMonthの1ヶ月後の1秒前を取得
        let endOfMonth = calendar.date(byAdding: .month, value: 1, to: startOfMonth)?.addingTimeInterval(-1)
    else {
        return nil
    }
    
    var dates: [Date] = []
    var currentDate = startOfMonth
    // 月の初日から末日までの日付を配列に追加するループ
    while currentDate <= endOfMonth {
        // 現在の日付を配列に追加
        dates.append(currentDate)
        
        // 翌日の日付を計算し、currentDateを更新
        if let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate) {
            currentDate = nextDate
        } else {
            // 翌日の日付を計算できない場合はループを抜ける
            break
        }
    }
    
    // 月の全日付が含まれた配列を返す
    return dates
}
