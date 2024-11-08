//
//  NewBookView.swift
//  MyBooks
//
//  Created by Lori Rothermel on 11/5/24.
//

import SwiftUI

struct NewBookView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var title = ""
    @State private var author = ""
        
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Book Title", text: $title)
                TextField("Book's Author", text: $author)
                
                Button("Create") {
                    let newBook = Book(title: title, author: author)
                    context.insert(newBook)
                    dismiss()
                }  // Button - Create
                .buttonStyle(.borderedProminent)
                .tint(.red)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.vertical)
                .disabled(title.isEmpty || author.isEmpty)
                
            }  // Form
            .navigationTitle("New Book")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }  // Button - Cancel
                }  // ToolbarItem
            }  // .toolbar
            
        }  // NavigationStack
        
    }  // some View
    
}  // NewBookView



#Preview {
    NewBookView()
}
