//
//  MonthlyCalendar.swift
//  Calendar
//
//  Created by tsonobe on 2023/10/11.
//

import SwiftUI
import SwiftData

struct MonthlyCalendar: View {
    @Environment(\.modelContext) private var context
    @Binding var selectedMonth: Date
    @Binding var selectedDate: Date
    
    let week = ["Sum", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    // selectedMonthの属する月の、初日~末日のDateのリストを生成
    var dateOfMonth: [Date] {
        generateDatesOfMonth(for: selectedMonth)!
    }
    
    var body: some View {
        ScrollView {
            HStack {
                // 曜日のリストを横向きに展開
                ForEach(week, id: \.self) { i in
                    Text(i)
                        .frame(maxWidth: .infinity)
                }
            }
            
            // 月の日付を縦向きに展開
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 0) { // カラム数の指定
                // 月の開始の曜日を取得
                let start = dateOfMonth[0].getWeekDay()
                // 月の終わりの曜日を取得
                let end = start + dateOfMonth.count
                
                // 7列で42個のブロックがあれば、カレンダーの全てのパターンを表現できる
                ForEach(0...41, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.clear)
                        .frame(width: 60, height: 60)
                    // 設置した42個のブロックの上に、日付を表示する
                        .overlay {
                            if (index >= start && index < end){
                                let i = index - start
                                
                                // 日付を表示
                                Text(DateFormatter.dayFormatter.string(from: dateOfMonth[i]))
                                    .foregroundStyle(Calendar.current.isDate(dateOfMonth[i], equalTo: Date(), toGranularity: .day) ? Color.cyan : Color.primary)
                                    .onTapGesture {
                                        withAnimation(.easeInOut(duration: 0.3)){
                                            // タップするとselectedDateが更新
                                            // EventListがselectedDateの値を監視しているので、
                                            // selectedDateが更新されるとEventListが再描画される
                                            selectedDate = dateOfMonth[i]
                                        }
                                    }
                                // 選択された日付に丸い背景を表示する
                                    .background(
                                        Circle()
                                            .fill(Calendar.current.isDate(dateOfMonth[i], equalTo: selectedDate, toGranularity: .day) ? Color.cyan : Color.clear)
                                            .opacity(0.4)
                                            .frame(width: 35, height: 35)
                                    )
                            }else {
                                // 日付が存在しない場合は空白を表示する
                                Text("")
                            }
                        }
                }
            }
            EventList(selectedDate: $selectedDate)
        }
    }
}

#Preview {
    ContentView()
}
