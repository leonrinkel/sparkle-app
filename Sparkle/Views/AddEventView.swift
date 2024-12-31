//
//  AddEventView.swift
//  Sparkle
//
//  Created by Leon Rinkel on 30.12.24.
//

import SwiftUI

struct AddEventView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var emoji: String = ""
    @State private var title: String = ""
    
    var body: some View {
        EventForm {
            Section(header: Text("Event Title")) {
                EventGroupBox {
                    TextField("Enter title here…", text: $title)
                }
            }
            Section(header: Text("Emoji")) {
                EventGroupBox {
                    TextField("Enter emoji here…", text: $emoji)
                }
            }
        }
        .frame(idealWidth: LayoutConstants.sheetIdealWidth, idealHeight: LayoutConstants.sheetIdealHeight)
        .navigationTitle("Add Event")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Dismiss") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .primaryAction) {
                Button("Done") {
                    addEvent()
                    dismiss()
                }
                .disabled(title.isEmpty || emoji.isEmpty)
            }
        }
    }
    
    private func addEvent() {
        withAnimation {
            let newEvent = TrackedEvent(emoji: emoji, title: title)
            modelContext.insert(newEvent)
        }
    }
    
}

#Preview(traits: .sampleData) {
    AddEventView()
}
