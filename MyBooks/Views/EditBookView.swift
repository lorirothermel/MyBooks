//
//  EditBookView.swift
//  MyBooks
//
//  Created by Lori Rothermel on 11/6/24.
//

import SwiftUI

struct EditBookView: View {
//    let book: Book
       
    @State private var status = Status.onShelf
    @State private var rating: Int?
    @State private var title = ""
    @State private var author = ""
    @State private var summary = ""
    @State private var dateAdded = Date.distantPast
    @State private var dateStarted = Date.distantPast
    @State private var dateCompleted = Date.distantPast
    
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
                        DatePicker("", selection: $dateStarted, displayedComponents: .date)
                    } label: {
                        Text("Date Started")
                    }  // labeledContent
                }  // if - .inProgress or .completed
                
                if status == .completed {
                    LabeledContent {
                        DatePicker("", selection: $dateCompleted, displayedComponents: .date)
                    } label: {
                        Text("Date Completed")
                    }  // labeledContent
                }  // if - .completed
                
            }  // GroupBox
            .foregroundStyle(.secondary)
            .onChange(of: status) { oldValue, newValue in
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
            }  // .onChange
            
            Divider()
            
            
        }  // VStack
        
        
    }  // some View
    
}  // EditBookView

#Preview {
    EditBookView()
}
