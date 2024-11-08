//
//  MyBooksApp.swift
//  MyBooks
//
//  Created by Lori Rothermel on 11/5/24.
//

import SwiftUI
import SwiftData


@main
struct MyBooksApp: App {
    var body: some Scene {
        WindowGroup {
            BookListView()
        }  // WindowGroup
        .modelContainer(for: Book.self)
    }  // some Scene
    
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }  // init()
    
    
}  // struct MyBooksApp
