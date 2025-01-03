//
//  Book.swift
//  MyBooks
//
//  Created by Lori Rothermel on 11/5/24.
//

import SwiftUI
import SwiftData


@Model
class Book {
    var title: String
    var author: String
    var dateAdded: Date
    var dateStarted: Date
    var dateCompleted: Date
    @Attribute(originalName: "summary")
    var synopsis: String
    var rating: Int?
    var status: Status.RawValue
    var recommendedBy: String = ""
    
    init(
        title: String,
        author: String,
        dateAdded: Date = Date.now,
        dateStarted: Date = Date.distantPast,
        dateCompleted: Date = Date.distantPast,
        synopsis: String = "",
        rating: Int? = nil,
        status: Status = .onShelf,
        recommendedBy: String = ""
    ) {
        self.title = title
        self.author = author
        self.dateAdded = dateAdded
        self.dateStarted = dateStarted
        self.dateCompleted = dateCompleted
        self.synopsis = synopsis
        self.rating = rating
        self.status = status.rawValue
        self.recommendedBy = recommendedBy
    }  // init
    
    var icon: Image {
        switch Status(rawValue: status)! {
            case .onShelf:
                Image(systemName: "checkmark.diamond.fill")
            case .inProgress:
                Image(systemName: "book.fill")
            case .completed:
                Image(systemName: "books.vertical.fill")
            }  // switch
    }  // var icon
    
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
