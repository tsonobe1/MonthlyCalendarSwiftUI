//
//  EventList.swift
//  Calendar
//
//  Created by tsonobe on 2023/10/11.
//

import SwiftUI
import SwiftData

struct EventList: View {
    @Environment(\.modelContext) private var context
    // SwiftDataでEventを取得
    @Query(sort: \Event.startDate, order: .forward) var events: [Event]
    
    @Binding var selectedDate: Date
    @State private var selectedEvent: Event?
    @State private var isAddSheet: Bool = false
    
    // selectedDateと同じ日付(00:00~23:59)に存在するEventのみ抽出する
    var filterdEvents: [Event] {
        return events.filter({
            dateIsInRange(selectedDate, startDate: $0.startDate, endDate: $0.endDate)
        })
    }
    
    var body: some View {
        VStack{
            HStack {
                // selectedDateを表示
                Text(DateFormatter.shortDateForm.string(from: selectedDate))
                    .font(.title3)
                    .bold()
                Spacer()
                // Eventを追加するボタン
                Button(action: {isAddSheet.toggle()}) {
                    Image(systemName: "plus")
                        .font(.title2)
                        .opacity(filterdEvents.count == 0 ? 0 : 1)
                }
            }
            ScrollView{
                // 操作日にEventが存在しない場合
                if filterdEvents.isEmpty {
                    ContentUnavailableView {Label("No Event", systemImage: "plus")}
                        .onTapGesture {isAddSheet.toggle()}
                } else {
                    // 操作日にEventが存在する場合
                    ForEach(filterdEvents) { event in
                        EventRow(event: event)
                        // Eventをタップした時の処理
                            .contextMenu(menuItems: {
                                // Eventを編集するボタン
                                Button {
                                    selectedEvent = event  // 選択されたeventを保存
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                // Eventを削除するボタン
                                Button {
                                    context.delete(event)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            })
                        
                    }
                }
            }
        }
        // Eventを編集するシート
        .sheet(item: $selectedEvent){ event in
            EditEvent(selectedEvent: event)
        }
        // Eventを追加するシート
        .sheet(isPresented: $isAddSheet) {
            AddEvent(selectedDate: selectedDate)
        }
    }
    
    // 第一引数のdateが、startDateとendDateの範囲内にあるかどうかを判定する
    func dateIsInRange(_ date: Date, startDate: Date, endDate: Date) -> Bool {
        let calendar = Calendar.current
        
        // 各引数のDateの時間部分を全て00:00:00にする
        let dateOnly = calendar.startOfDay(for: date)
        let startDateOnly = calendar.startOfDay(for: startDate)
        let endDateOnly = calendar.startOfDay(for: endDate)
        
        // 時間部分の条件を同じ(00:00:00)にしたため、純粋に年月日のみに基づいて範囲比較が行える
        return dateOnly >= startDateOnly && dateOnly <= endDateOnly
    }

}

#Preview {
    ContentView()
}


struct EventRow: View {
    let event: Event
    
    private var dateView: some View {
        Group{
            VStack(alignment: .center) {
                Text(DateFormatter.shortTimeForm.string(from: event.startDate))
                Text(DateFormatter.shortTimeForm.string(from: event.endDate))
            }
            .font(.caption2)
        }
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 1) {
            Text(event.title)
                .font(.callout)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            dateView.padding(.trailing, 10)
        }
        .background{EventBackground(color: .blue)}
        .padding(.vertical, 5)
    }
}
