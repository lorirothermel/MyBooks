//
//  QuotesListView.swift
//  MyBooks
//
//  Created by Lori Rothermel on 11/9/24.
//

import SwiftUI
import SwiftData


struct QuotesListView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var text = ""
    @State private var page = ""
    @State private var selectedQuote: Quote?
    
    var isEditing: Bool {
        selectedQuote != nil
    }  // isEditing
    
    let book: Book
    
    
    var body: some View {
        GroupBox {
            HStack {
                LabeledContent("Page") {
                    TextField("Page #:", text: $page)
                        .autocorrectionDisabled()
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 150)
                    Spacer()
                }  // LabeledContent - Page
                
                if isEditing {
                    Button("Cancel") {
                        page = ""
                        text = ""
                        selectedQuote = nil
                    }  // Button - Cancel
                    .buttonStyle(.bordered)
                }  // if
                
                Button(isEditing ? "Update" : "Create") {
                    if isEditing {
                        selectedQuote?.text = text
                        selectedQuote?.page = page.isEmpty ? nil : page
                        page = ""
                        text = ""
                        selectedQuote = nil
                    } else {
                        let quote = page.isEmpty ? Quote(text: text) : Quote(text: text, page: page)
                        book.quotes?.append(quote)
                        page = ""
                        text = ""
                    }  // if...else
                }  // Button - Update or Create
                .buttonStyle(.borderedProminent)
                .disabled(text.isEmpty)
                
            }  // HStack
            
            TextEditor(text: $text)
                .border(.secondary)
                .frame(height: 100)
            
        }  // GroupBox
        .padding(.horizontal)
               
        List {
            let sortedQuotes = book.quotes?.sorted(using: KeyPathComparator(\Quote.creationDate)) ?? []
            
            ForEach(sortedQuotes) { quote in
                VStack(alignment: .leading) {
                    Text(quote.creationDate, format: .dateTime.month().day().year())
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(quote.text)
                    
                    HStack {
                        Spacer()
                        if let page = quote.page, !page.isEmpty {
                            Text("Page: \(page)")
                        }  // if
                    }  // HStack
                }  // VStack
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedQuote = quote
                    text = quote.text
                    page = quote.page ?? ""
                }  // .onTapGesture
                
            }  // ForEach
            .onDelete { indexSet in
                withAnimation {
                    indexSet.forEach { index in
                        let quote = sortedQuotes[index]
                        book.quotes?.forEach { bookQuote in
                            if quote.id == bookQuote.id {
                                modelContext.delete(quote)
                            }  // if
                        }  // forEach
                    }  // forEach
                }
            }  // .onDelete
            
        }  // List
        .listStyle(.plain)
        .navigationTitle("Quotes")
        
    }  // some View
    
}  // QuotesListView


#Preview {
    let preview = Preview(Book.self)
    let books = Book.sampleBooks
    preview.addExamples(books)
    return NavigationStack {
        QuotesListView(book: books[4])
            .navigationBarTitleDisplayMode(.inline)
            .modelContainer(preview.container)
    }
}
