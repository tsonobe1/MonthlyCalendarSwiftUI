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
    @State private var isAddSheet: Bool = false
    @State private var isEditSheet = false
    
    // selectedDateの日付(00:00~23:00)に存在するEventを取得
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
                                    isEditSheet.toggle()
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
                        // Eventを編集するシート
                            .sheet(isPresented: $isEditSheet){
                                EditEvent(selectedEvent: event)
                            }
                    }
                }
            }
        }
        // Eventを追加するシート
        .sheet(isPresented: $isAddSheet) {
            AddEvent(selectedDate: selectedDate)
        }
    }
    
    /// 与えられた日付が指定された範囲内にあるかどうかを判断する関数。
    ///
    /// - Parameters:
    ///   - dateC: 確認したい日付。
    ///   - startDate: 範囲の開始日付。
    ///   - endDate: 範囲の終了日付。
    /// - Returns: 日付が範囲内であれば`true`、そうでなければ`false`。
    func dateIsInRange(_ dateC: Date, startDate: Date, endDate: Date) -> Bool {
        let calendar = Calendar.current
        // 日付から年、月、日のみの情報を取得
        let componentsC = calendar.dateComponents([.year, .month, .day], from: dateC)
        let dateOnlyC = calendar.date(from: componentsC)!
        
        let componentsStart = calendar.dateComponents([.year, .month, .day], from: startDate)
        let dateOnlyStart = calendar.date(from: componentsStart)!
        
        let componentsEnd = calendar.dateComponents([.year, .month, .day], from: endDate)
        let dateOnlyEnd = calendar.date(from: componentsEnd)!
        
        // 日付の範囲内にあるかどうかを判断
        return dateOnlyC >= dateOnlyStart && dateOnlyC <= dateOnlyEnd
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
