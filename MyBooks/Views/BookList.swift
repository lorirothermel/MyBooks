//
//  BookList.swift
//  MyBooks
//
//  Created by Lori Rothermel on 11/8/24.
//

import SwiftUI
import SwiftData


struct BookList: View {
    @Environment(\.modelContext) private var context
    @Query private var books: [Book]

    
    init(sortOrder: SortOrder, filterString: String) {
        let sortDescriptors: [SortDescriptor<Book>] = switch sortOrder {
        case .status:
            [SortDescriptor(\Book.status), SortDescriptor(\Book.title)]
        case .title:
            [SortDescriptor(\Book.title)]
        case .author:
            [SortDescriptor(\Book.author)]
        }  // switch - SortOrder
        
        let predicate = #Predicate<Book> { book in
            book.title.localizedStandardContains(filterString)  ||
            book.author.localizedStandardContains(filterString) ||
            filterString.isEmpty
        }  // predicate
                
        _books = Query(filter: predicate, sort: sortDescriptors)
        
    }  // init
    
    var body: some View {
        
        Group {
            if books.isEmpty {
                ContentUnavailableView("Enter Your First Book", systemImage: "book.fill")
            } else {
                List {
                    ForEach(books) { book in
                        NavigationLink {
                            EditBookView(book: book)
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
                                            ForEach(1..<rating, id: \.self) { _ in
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


    }
}

#Preview {
    let preview = Preview(Book.self)
    preview.addExamples(Book.sampleBooks)
    return NavigationStack {
        BookList(sortOrder: .status, filterString: "")
    }  // NavigationStack
    .modelContainer(preview.container)
    
}
