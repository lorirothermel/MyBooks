//
//  Book.swift
//  MyBooks
//
//  Created by Lori Rothermel on 11/5/24.
//

import Foundation
import SwiftData


@Model
class Book {
    var title: String
    var author: String
    var dateAdded: Date
    var dateStarted: Date
    var dateCompleted: Date
    var summary: String
    var rating: Int?
    var status: Status
    
    init(
        title: String,
        author: String,
        dateAdded: Date = Date.now,
        dateStarted: Date = Date.distantPast,
        dateCompleted: Date = Date.distantPast,
        summary: String = "",
        rating: Int? = nil,
        status: Status = .onShelf
    ) {
        self.title = title
        self.author = author
        self.dateAdded = dateAdded
        self.dateStarted = dateStarted
        self.dateCompleted = dateCompleted
        self.summary = summary
        self.rating = rating
        self.status = status
    }  // init
    
    
    
}  // class Book


enum Status: Int, Codable, Identifiable, CaseIterable {
    case onShelf, inProgress, completed
    
    var id: Self {
        self
    }  // var id
    
    var descr: String {
        switch self {
            case .onShelf: "On Shelf"
            case .inProgress: "In Progress"
            case .completed: "Completed"
        }  // switch self
    }  // var descr
    
}  // enum Status
