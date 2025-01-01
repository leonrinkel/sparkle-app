//
//  EventsSortOrder.swift
//  Sparkle
//
//  Created by Leon Rinkel on 01.01.25.
//

import Foundation

@Observable class EventsSortOrder {
    
    var listBy: EventsListBy = .dateAdded
    var dateAddedOrder: DateAddedOrder = .oldestFirst
    var titleOrder: TitleOrder = .ascending
    
}

// TODO: Add times logged sorting
enum EventsListBy: CaseIterable, Identifiable, CustomStringConvertible {

    case manual
    case dateAdded
    case title
    
    var id: Self { self }

    var description: String {
        switch self {
        case .manual:
            return "Manual"
        case .dateAdded:
            return "Date Added"
        case .title:
            return "Title"
        }
    }
    
}

enum DateAddedOrder: CaseIterable, Identifiable, CustomStringConvertible {
    
    case oldestFirst
    case newestFirst
    
    var id: Self { self }
    
    var description: String {
        switch self {
        case .oldestFirst:
            return "Oldest First"
        case .newestFirst:
            return "Newest First"
        }
    }

}

enum TitleOrder: CaseIterable, Identifiable, CustomStringConvertible {
    
    case ascending
    case descending
    
    var id: Self { self }
    
    var description: String {
        switch self {
        case .ascending:
            return "Ascending"
        case .descending:
            return "Descending"
        }
    }

}
