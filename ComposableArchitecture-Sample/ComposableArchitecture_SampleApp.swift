//
//  ComposableArchitecture_SampleApp.swift
//  ComposableArchitecture-Sample
//
//  Created by Tiago Oliveira on 12/11/23.
//

import ComposableArchitecture
import SwiftUI

@main
struct ComposableArchitecture_SampleApp: App {
    // MARK: It is important to note that the Store that powers the application should only be created a single time. For most applications it should be sufficient to create it directly in the WindowGroup at the root of the scene. But, it can also be held as a static variable and then provided in the scene.
    
    // TIP: `_printChanges` it will print every action that the reducer processes to the console, and it will print how the state changed after processing the action.
    static let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            CounterFeatureView(store: ComposableArchitecture_SampleApp.store)
        }
    }
}
