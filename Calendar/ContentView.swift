//
//  ContentView.swift
//  Calender
//
//  Created by tsonobe on 2023/10/11.
//

import SwiftUI

struct ContentView: View {
    @State var selectedMonth: Date = Date()
    
    var body: some View {
        NavigationStack{
            VStack{
                MonthSelector(selectedMonth: $selectedMonth)
                MonthlyCalendar(selectedMonth: $selectedMonth)
            }
            .padding()
        }
    }
}


#Preview {
    ContentView()
//        .modelContainer(for: Item.self, inMemory: true)
}



struct MonthSelector: View {
    @Binding var selectedMonth: Date
    
    var body: some View {
        HStack(alignment: .center) {
            monthButton(direction: .backward)
            Spacer()
            currentMonthAndYear
            Spacer()
            monthButton(direction: .forward)
        }
    }
    
    // 現在の月と年を表示するサブビュー
    private var currentMonthAndYear: some View {
        HStack {
            Text(DateFormatter.monthFormatter.string(from: selectedMonth))
                .foregroundStyle(isSameMonthAsToday ? .cyan : .primary)
                .font(.title2)
            
            Text(DateFormatter.yearFormatter.string(from: selectedMonth))
                .foregroundStyle(isSameYearAsToday ? .cyan : .primary)
                .font(.title)
                .bold()
        }
    }
    
    // 今日とselectedMonthが同じかどうか
    private var isSameMonthAsToday: Bool {
        Calendar.current.isDate(Date(), equalTo: selectedMonth, toGranularity: .month)
    }
    
    // 今日とselectedMonthが同じかどうか
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
