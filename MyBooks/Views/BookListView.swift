//
//  ContentView.swift
//  MyBooks
//
//  Created by Lori Rothermel on 11/5/24.
//

import SwiftUI
import SwiftData


struct BookListView: View {
    @Environment(\.modelContext) private var context
    
    @Query(sort: \Book.title) private var books: [Book]
    
    @State private var createNewBook = false
    
    
    var body: some View {
        NavigationStack {
            Group {
                if books.isEmpty {
                    ContentUnavailableView("Enter Your First Book", systemImage: "book.fill")
                } else {
                    List {
                        ForEach(books) { book in
                            NavigationLink {
                                Text(book.title)
                            } label: {
                                HStack(spacing: 10) {
                                    book.icon
                                    VStack(alignment: .leading) {
                                        Text(book.title)
                                            .font(.title2)
                                        Text(book.author)
                                            .foregroundStyle(.secondary)
                                        if let rating = book.rating {
                                            HStack {
                                                ForEach(0..<rating, id: \.self) { _ in
                                                    Image(systemName: "star.fill")
                                                        .imageScale(.small)
                                                        .foregroundStyle(.yellow)
                                                }  // ForEach
                                            }  // HStack
                                        }  // if let
                                    }  // VStack
                                }  // HStack
                            }  // NavigationLink

                        }  // ForEach
                        .onDelete { indexSet in
                            indexSet.forEach { index in
                                let book = books[index]
                                context.delete(book)
                            }  // indexSet
                        }  // .onDelete
                    }  // List
                }  // if...else
            }  // Group
            
            .padding()
            .navigationTitle("My Books")
            .toolbar {
                Button {
                    createNewBook = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                }  // Button
            }  // .toolbar
            .sheet(isPresented: $createNewBook) {
                NewBookView()
                    .presentationDetents([.medium])
            }  // .sheet
        }  // NavigationStack
        
        
    }  // some View
    
}  // BookListView

#Preview {
    BookListView()
        .modelContainer(for: Book.self, inMemory: true)
}
