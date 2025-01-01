//
//  EditEventView.swift
//  Sparkle
//
//  Created by Leon Rinkel on 01.01.25.
//

import SwiftUI

struct EditEventView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State var event: TrackedEvent

    @State private var draft: TrackedEvent.Draft
    @State private var isEmojiPickerPresented: Bool = false
    
    init(event: TrackedEvent) {
        self.event = event
        self.draft = .from(event)
    }
    
    var body: some View {
        Form {
            Section(header: Text("Title")) {
                EventGroupBox {
                    TextField("Ate Pizza", text: $draft.title)
                }
            }
            Section(header: Text("Symbol")) {
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
        .navigationTitle("Edit Event")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .primaryAction) {
                Button("Save") {
                    applyDraft()
                    dismiss()
                }
                .disabled(!draft.isValid)
            }
        }
    }
    
    private func applyDraft() {
        event.title = draft.title
        event.emoji = draft.emoji
        event.color = draft.color
    }
    
}

#Preview(traits: .sampleData) {
    EditEventView(event: .previewEvents.first!)
}
