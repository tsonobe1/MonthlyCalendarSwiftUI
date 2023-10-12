//
//  MonthlyCalendar.swift
//  Calender
//
//  Created by tsonobe on 2023/10/11.
//

import SwiftUI
import SwiftData

struct MonthlyCalendar: View {
    @Environment(\.modelContext) private var context
    @Binding var selectedMonth: Date
    @State var selectedDate: Date = Date()
    
    let week = ["Sum", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    var dateOfMonth: [Date] {
        generateDatesOfMonth(for: selectedMonth)!
    }
    
    var body: some View {
        ScrollView {
            HStack {
                ForEach(week, id: \.self) { i in
                    Text(i)
                        .frame(maxWidth: .infinity)
                }
            }
            
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 0) { // カラム数の指定
                let start = dateOfMonth[0].getWeekDay()
                let end = start + dateOfMonth.count
                
                ForEach(0...41, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.clear)
                        .frame(width: 60, height: 60)
                        .overlay {
                            if (index >= start && index < end){
                                let i = index - start
                                
                                Text(DateFormatter.dayFormatter.string(from: dateOfMonth[i]))
                                    .foregroundStyle(Calendar.current.isDate(dateOfMonth[i], equalTo: Date(), toGranularity: .day) ? Color.cyan : Color.primary)
                                    .onTapGesture {
                                        withAnimation(.easeInOut(duration: 0.3)){
                                            selectedDate = dateOfMonth[i]
                                        }
                                    }
                                    .background(
                                        Circle()
                                            .fill(Calendar.current.isDate(dateOfMonth[i], equalTo: selectedDate, toGranularity: .day) ? Color.cyan : Color.clear)
                                            .opacity(0.4)
                                            .frame(width: 35, height: 35)
                                    )
                            }else {
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
