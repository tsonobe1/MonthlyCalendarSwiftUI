//
//  EditEvent.swift
//  Calendar
//
//  Created by tsonobe on 2023/10/12.
//

import SwiftUI

struct EditEvent: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    var selectedEvent: Event
    
    @State private var title: String
    @State private var detail: String
    @State private var startDate: Date
    @State private var endDate: Date
    
    init(selectedEvent: Event) {
        self.selectedEvent = selectedEvent
        _title = State(initialValue: selectedEvent.title)
        _detail = State(initialValue: selectedEvent.detail)
        _startDate = State(initialValue: selectedEvent.startDate)
        _endDate = State(initialValue: selectedEvent.endDate)
    }
        
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Basic")) {
                    TextField("Title", text: $title)
                    TextField("Detail", text: $detail)
                }
                
                Section {
                    DatePicker("Start", selection: $startDate)
                        .foregroundStyle(startDate > endDate ? .red : .primary)
                    
                    DatePicker("End",selection: $endDate)
                        .foregroundStyle(startDate > endDate ? .red : .primary)
                } header: {
                    Text("Start Date ~ End Date")
                } footer: {
                    Text("Start date should be before end date.")
                        .foregroundColor(.red)
                        .font(.caption2)
                        .opacity(startDate > endDate ? 1 : 0)
                }
                
                Section {
                    Button("Update") {
                        selectedEvent.title = title
                        selectedEvent.detail = detail
                        selectedEvent.startDate = startDate
                        selectedEvent.endDate = endDate
                        dismiss()
                    }
                    .disabled(title.isEmpty || startDate > endDate)
                }
            }
        }
    }
}
