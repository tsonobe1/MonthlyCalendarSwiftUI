//
//  ContentView.swift
//  Calendar
//
//  Created by tsonobe on 2023/10/11.
//

import SwiftUI

struct ContentView: View {
    @State var selectedMonth: Date = Date()
    @State var selectedDate: Date = Date()
    
    var body: some View {
        VStack{
            MonthSelector(selectedMonth: $selectedMonth, selectedDate: $selectedDate)
            MonthlyCalendar(selectedMonth: $selectedMonth, selectedDate: $selectedDate)
        }
        .padding()
    }
}


#Preview {
    ContentView()
}
