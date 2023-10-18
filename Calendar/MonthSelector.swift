//
//  MonthSelector.swift
//  Calendar
//
//  Created by tsonobe on 2023/10/19.
//

import SwiftUI

struct MonthSelector: View {
    @Binding var selectedMonth: Date
    @Binding var selectedDate: Date

    var body: some View {
        VStack(alignment: .trailing) {
            // 操作日にリセットするボタン
            Button(action: {
                selectedMonth = Date()
                selectedDate = Date()
            }, label: {
                Text("Today")
            })
            HStack(alignment: .center) {
                // 前の月を表示
                monthButton(direction: .backward)
                Spacer()
                // 表示中の年と月
                currentMonthAndYear
                Spacer()
                // 次の月を表示
                monthButton(direction: .forward)
            }
        }
    }
    
    // 現在の月と年を表示するサブビュー
    private var currentMonthAndYear: some View {
        HStack {
            // 月
            Text(DateFormatter.monthFormatter.string(from: selectedMonth))
                .foregroundStyle(isSameMonthAsToday ? .cyan : .primary)
                .font(.title2)
            // 年
            Text(DateFormatter.yearFormatter.string(from: selectedMonth))
                .foregroundStyle(isSameYearAsToday ? .cyan : .primary)
                .font(.title)
                .bold()
        }
    }
    
    // 操作日とselectedMonthが同じかどうかを判定
    private var isSameMonthAsToday: Bool {
        Calendar.current.isDate(Date(), equalTo: selectedMonth, toGranularity: .month)
    }
    
    // 操作日とselectedMonthが同じかどうかを判定
    private var isSameYearAsToday: Bool {
        Calendar.current.isDate(Date(), equalTo: selectedMonth, toGranularity: .year)
    }

    // 前月または次月に移動するボタンのサブビュー
    private func monthButton(direction: MonthDirection) -> some View {
        let value = direction == .forward ? 1 : -1
        let symbol = direction == .forward ? "chevron.right" : "chevron.left"
        
        return Button(action: {
            withAnimation(.easeInOut(duration: 0.1)){
                adjustMonth(by: value)
            }
        }) {
            //
            HStack(alignment: .center) {
                if direction == .backward { Image(systemName: symbol) }
                Text(DateFormatter.monthFormatter.string(from: monthAdjusted(by: value)))
                if direction == .forward { Image(systemName: symbol) }
            }
            .font(.title3)
        }
    }
    
    // selectedMonthを加算または減算する関数
    private func adjustMonth(by value: Int) {
        if let newMonth = Calendar.current.date(byAdding: .month, value: value, to: selectedMonth) {
            selectedMonth = newMonth
        }
    }
    
    // 与えられた値で月を調整した後の日付を返す関数
    private func monthAdjusted(by value: Int) -> Date {
        return Calendar.current.date(byAdding: .month, value: value, to: selectedMonth) ?? selectedMonth
    }
    
    private enum MonthDirection {
        case forward
        case backward
    }
}
