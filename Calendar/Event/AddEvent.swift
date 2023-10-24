//
//  AddEvent.swift
//  Calendar
//
//  Created by tsonobe on 2023/10/11.
//

import SwiftUI

struct AddEvent: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    var selectedDate: Date
    
    @State private var title: String = ""
    @State private var detail: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    
    init(selectedDate: Date) {
        self.selectedDate = selectedDate
        _startDate = State(initialValue: selectedDate)
        _endDate = State(initialValue: selectedDate)
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
                    Button("追加") {
                        let newEvent = Event(
                            id: UUID(),
                            title: title,
                            detail: detail,
                            startDate: startDate,
                            endDate: endDate,
                            createdData: Date()
                        )
                        context.insert(newEvent)
                        dismiss()
                    }
                    .disabled(title.isEmpty || startDate > endDate)
                }
            }
        }
    }
}
