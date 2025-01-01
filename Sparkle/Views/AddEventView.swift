//
//  AddEventView.swift
//  Sparkle
//
//  Created by Leon Rinkel on 30.12.24.
//

import SwiftUI
import MCEmojiPicker

struct AddEventView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var draft: TrackedEvent.Draft = .empty
    
    @State private var isEmojiPickerPresented: Bool = false
    
    var body: some View {
        EventForm {
            Section(header: Text("Title")) {
                EventGroupBox {
                    TextField("Ate Pizza", text: $draft.title)
                }
            }
            Section(header: Text("Symbol")) {
                EventGroupBox {
                    HStack {
                        Text("Emoji")
                        Spacer()
                        Button {
                            isEmojiPickerPresented.toggle()
                        } label: {
                            Text(draft.emoji)
                        }
                        .emojiPicker(isPresented: $isEmojiPickerPresented, selectedEmoji: $draft.emoji)
                    }
                    ColorPicker("Background", selection: $draft.color, supportsOpacity: false)
                }
            }
        }
        .navigationTitle("Add Event")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Dismiss") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .primaryAction) {
                Button("Add") {
                    addEvent()
                    dismiss()
                }
                .disabled(!draft.isValid)
            }
        }
    }
    
    private func addEvent() {
        withAnimation {
            let newEvent = TrackedEvent(from: draft)
            modelContext.insert(newEvent)
        }
    }
    
}

#Preview(traits: .sampleData) {
    AddEventView()
}
