//
//  EditBookView.swift
//  MyBooks
//
//  Created by Lori Rothermel on 11/6/24.
//

import SwiftUI

struct EditBookView: View {
    let book: Book
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var status = Status.onShelf
    @State private var rating: Int?
    @State private var title = ""
    @State private var author = ""
    @State private var synopsis = ""
    @State private var dateAdded = Date.distantPast
    @State private var dateStarted = Date.distantPast
    @State private var dateCompleted = Date.distantPast
    @State private var firstView = true
    @State private var recommendedBy = ""
    
    
    var changed: Bool {
        status != Status(rawValue: book.status)!
        || rating != book.rating
        || title != book.title
        || author != book.author
        || recommendedBy != book.recommendedBy
        || synopsis != book.synopsis
        || dateAdded != book.dateAdded
        || dateStarted != book.dateStarted
        || dateCompleted != book.dateCompleted
    }  // var changed
    
    
    var body: some View {
        HStack {
            Text("Status")
            Picker("Status", selection: $status) {
                ForEach(Status.allCases) { status in
                    Text(status.descr).tag(status)
                }  // ForEach
            }  // Picker - Status
            .buttonStyle(.bordered)
        }  // HStack
        VStack(alignment: .leading) {
            GroupBox {
                LabeledContent {
                    DatePicker("", selection: $dateAdded, displayedComponents: .date)
                } label: {
                    Text("Date Added")
                }  // labeledContent
                
                if status == .inProgress || status == .completed {
                    LabeledContent {
                        DatePicker("", selection: $dateStarted, in: dateAdded..., displayedComponents: .date)
                    } label: {
                        Text("Date Started")
                    }  // labeledContent
                }  // if - .inProgress or .completed
                
                if status == .completed {
                    LabeledContent {
                        DatePicker("", selection: $dateCompleted, in:dateAdded..., displayedComponents: .date)
                    } label: {
                        Text("Date Completed")
                    }  // labeledContent
                }  // if - .completed
                
            }  // GroupBox
            .foregroundStyle(.secondary)
            .onChange(of: status) { oldValue, newValue in
                if !firstView {
                    if newValue == .onShelf {
                        dateStarted = Date.distantPast
                        dateCompleted = Date.distantPast
                    } else if newValue == .inProgress && oldValue == .completed {
                        // From complete to inProgress
                        dateCompleted = Date.distantPast
                    } else if newValue == .inProgress && oldValue == .onShelf {
                        // Book has been started
                        dateStarted = Date.now
                    } else if newValue == .completed && oldValue == .onShelf {
                        // Forgot to start book
                        dateCompleted = Date.now
                        dateStarted = dateAdded
                    } else {
                        // completed
                        dateCompleted = Date.now
                    }  // if.then.else
                    firstView = false
                }  // if
            }  // .onChange
            
            Divider()
            
            LabeledContent {
                RatingsView(maxRating: 5, currentRating: $rating, width: 30)
            } label: {
                 Text("Rating")
            }  // LabeledContent
            
            LabeledContent {
                TextField("", text: $title)
            } label: {
                Text("Title:")
            }  // LabeledContent
           
            LabeledContent {
                TextField("", text: $author)
            } label: {
                 Text("Author:")
            }  // LabeledContent - recommendedBy
 
            LabeledContent {
                TextField("", text: $recommendedBy)
            } label: {
                 Text("Recommended By:")
            }  // LabeledContent - recommendedBy
            
            Divider()
            
            Text("Synopsis")
                .foregroundStyle(.secondary)
            TextEditor(text: $synopsis)
                .padding(5)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color(uiColor: .tertiarySystemFill), lineWidth: 2))
            
            
        }  // VStack
        .padding()
        .textFieldStyle(.roundedBorder)
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if changed {
                Button("Update") {
                    book.status = status.rawValue
                    book.rating = rating
                    book.title = title
                    book.author = author
                    book.synopsis = synopsis
                    book.dateAdded = dateAdded
                    book.dateStarted = dateStarted
                    book.dateCompleted = dateCompleted
                    book.recommendedBy = recommendedBy
                    dismiss()
                }  // Button - Update
                .buttonStyle(.borderedProminent)
            }  // if
        }  // .toolbar
        .onAppear {
            status = Status(rawValue: book.status)!
            rating = book.rating
            title = book.title
            author = book.author
            synopsis = book.synopsis
            recommendedBy = book.recommendedBy
            dateAdded = book.dateAdded
            dateStarted = book.dateStarted
            dateCompleted = book.dateCompleted
        }  // .onAppear
        
    }  // some View
    
}  // EditBookView

#Preview {
    let preview = Preview(Book.self)
    
    return NavigationStack {
        EditBookView(book: Book.sampleBooks[4])
            .modelContainer(preview.container)
    }
    
}
