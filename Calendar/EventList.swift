//
//  EventList.swift
//  Calender
//
//  Created by tsonobe on 2023/10/11.
//

import SwiftUI
import SwiftData

struct EventList: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Event.startDate, order: .forward) var events: [Event]
    @Binding var selectedDate: Date
    @State private var changedDate: Date = Date()
    @State private var isPresentedEdit = false
    
    var filterdEvents: [Event] {
        return events.filter({
            dateIsInRange(selectedDate, startDate: $0.startDate, endDate: $0.endDate)
        })
    }
    
    @State private var isAddEventSheetPresented: Bool = false
    @State var selectedEvent: Event? = nil

    
    var body: some View {
        VStack{
            HStack {
                let _ = print(filterdEvents)
                
                Text(DateFormatter.shortDateForm.string(from: selectedDate))
                    .font(.title3)
                    .bold()
                Spacer()
                Button(action: {isAddEventSheetPresented.toggle()}) {
                    Image(systemName: "plus")
                        .font(.title2)
                        .opacity(filterdEvents.count == 0 ? 0 : 1)
                }
            }
            ScrollView{
                if filterdEvents.isEmpty {
                    ContentUnavailableView {Label("No Schedule", systemImage: "plus")}
                        .onTapGesture {isAddEventSheetPresented.toggle()}
                }
                ForEach(filterdEvents) { event in
                    EventRow(event: event)
                        .contextMenu(menuItems: {
                            Button {
                                selectedEvent = event
                                let _ = print(selectedEvent!)
                                isPresentedEdit.toggle()
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            Button {
                                context.delete(event)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        })
                }
            }
        }
        .sheet(isPresented: $isAddEventSheetPresented) {
            AddEvent(selectedDate: selectedDate)
        }
        .sheet(isPresented: $isPresentedEdit){
            EditEvent(selectedEvent: selectedEvent)
        }
    }
    
    
    func dateIsInRange(_ dateC: Date, startDate: Date, endDate: Date) -> Bool {
        let calendar = Calendar.current
        // 日付のみを取得
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
        NavigationStack{
            NavigationLink {
                Text("TSET")
            } label: {
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
            .foregroundStyle(.primary)
        }
    }
}
