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
                Section(header: Text("基本情報")) {
                    TextField("タイトル", text: $title)
                    TextField("詳細", text: $detail)
                }
                
                Section {
                    DatePicker("開始", selection: $startDate)
                        .foregroundStyle(startDate > endDate ? .red : .primary)
                    
                    DatePicker("終了",selection: $endDate)
                        .foregroundStyle(startDate > endDate ? .red : .primary)
                } header: {
//                    Text("Start Date ~ End Date")
                } footer: {
                    Text("開始日は終了日より前にしてください。")
                        .foregroundColor(.red)
                        .font(.caption2)
                        .opacity(startDate > endDate ? 1 : 0)
                }
                
                Section {
                    Button("更新") {
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
