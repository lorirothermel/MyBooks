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
    let container: ModelContainer
    
    
    var body: some Scene {
        WindowGroup {
            BookListView()
        }  // WindowGroup
        .modelContainer(container)
    }  // some Scene
    
    init() {
        
        let schema = Schema([Book.self])
        let config = ModelConfiguration("MyBooks", schema: schema)
        
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("🤬 Could not configure the container!")
        }  // do..catch
        
        print(URL.documentsDirectory.path())
           
    }  // init()
    
    
}  // struct MyBooksApp
