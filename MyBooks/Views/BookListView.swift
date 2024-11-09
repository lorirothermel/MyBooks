//
//  ContentView.swift
//  MyBooks
//
//  Created by Lori Rothermel on 11/5/24.
//

import SwiftUI
import SwiftData


enum SortOrder: String, Identifiable, CaseIterable {
    case status
    case title
    case author
    
    var id: Self {
        self
    }  // var id
    
}  // enum SortOrder


struct BookListView: View {
    @State private var createNewBook = false
    @State private var sortOrder = SortOrder.status
    @State private var filter = ""
    
    
    var body: some View {
        NavigationStack {
            Picker("", selection: $sortOrder) {
                ForEach(SortOrder.allCases) { sortOrder in
                    Text("Sort by \(sortOrder.rawValue.capitalized)")
                        .tag(sortOrder)
                }  // ForEach
            }  // Picker - sortOrder
            .buttonStyle(.bordered)
            
            BookList(sortOrder: sortOrder, filterString: filter)
                .searchable(text: $filter, prompt: "Filter on Title or Author")
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
    let preview = Preview(Book.self)
    preview.addExamples(Book.sampleBooks)
    return BookListView()
        .modelContainer(preview.container)
}
