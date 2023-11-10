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
    
    let week = ["日", "月", "火", "水", "木", "金", "土"]
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
                // 月の開始日の曜日を取得 (0 = 日曜日, 6 = 土曜日)
                let start = dateOfMonth[0].getWeekDay()
                let _ = print("start: \(start)")
                // 月の終了日の曜日を取得
                // 2023年11月なら、startが水曜日=3 のため、endは33
                let end = start + dateOfMonth.count
                let _ = print("end: \(end)")

                
                // 7列で42個のセルがあれば、カレンダーの全てのパターンを表現できる
                // indexは0から41までの整数で、それぞれのセルを表す。
                ForEach(0...41, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.clear)
                        .frame(width: 60, height: 60)
                    // 設置した42個のブロックの上に、日付を表示する
                        .overlay {
                            // 0から41の整数値をforループで回しているときの値=indexが、
                            // start 以上、end 未満かどうかを判定している
                            //　2023年11月なら、start=3,end=33のため、indexが3~33に該当するループで、trueとなり、日付を上乗せ表示する
                            if (index >= start && index < end){
                                
                                // 現在の index から月の最初の日のインデックス（start）を減算した値を取得する
                                // indexからstartを引くことで、dateOfMonth配列の正しい位置を求める。
                                
                                // 2023年11月1日なら、indexが3の時からtrueとなる
                                // はじめは、index=3, start=3のため、iには0が入る。
                                // 11月の全ての日付が格納されている"dateOfMonth"の添字として、iを使うことで、11月のゼロ番目=初日を表示する
                                
                                // 次のループでは、index=4, start=3のため、iには1が入る。
                                // "dateOfMonth"の添字として、iを使うことで、11月2日を表示する

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
                                // indexがstart未満またはend以上の場合、グリッドのセルは実際の月の日付範囲外となる
                                // このため、対応するセルには何も表示しない（空白のテキストを配置する）
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
