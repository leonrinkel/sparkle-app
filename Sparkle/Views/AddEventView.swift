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
    
    @State private var isEmojiPickerPresented: Bool = false
    
    @State private var color: Color = Color(UIColor.lightGray)
    @State private var emoji: String = "🍕"
    @State private var title: String = ""
    
    var body: some View {
        EventForm {
            Section(header: Text("Title")) {
                EventGroupBox {
                    TextField("Ate Pizza", text: $title)
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
                            Text(emoji)
                        }
                        .emojiPicker(isPresented: $isEmojiPickerPresented, selectedEmoji: $emoji)
                    }
                    ColorPicker("Background", selection: $color, supportsOpacity: false)
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
                .disabled(title.isEmpty || emoji.isEmpty)
            }
        }
    }
    
    private func addEvent() {
        withAnimation {
            let newEvent = TrackedEvent(color: UIColor(color), emoji: emoji, title: title, addedAt: .now, loggedInstances: [])
            modelContext.insert(newEvent)
        }
    }
    
}

#Preview(traits: .sampleData) {
    AddEventView()
}
