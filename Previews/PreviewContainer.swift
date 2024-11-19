//
//  PreviewContainer.swift
//  MyBooks
//
//  Created by Lori Rothermel on 11/7/24.
//

import Foundation
import SwiftData


struct Preview {
    let container: ModelContainer
    
    init(_ models: any PersistentModel.Type...) {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let schema = Schema(models)
        
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("🤬 Could not create preview container!")
        }  // do..catch
        
    }  // init
    
    
    func addExamples(_ examples: [any PersistentModel]) {
        Task { @MainActor in
            examples.forEach { example in
                container.mainContext.insert(example)
            }  // forEach
        }  // Task
        
    }  // func addExamples
    
    
}
