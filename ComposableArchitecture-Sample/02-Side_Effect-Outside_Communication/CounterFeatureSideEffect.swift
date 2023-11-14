//
//  CounterFeatureSideEffect.swift
//  ComposableArchitecture-Sample
//
//  Created by Tiago Oliveira on 13/11/23.
//

import ComposableArchitecture

struct CounterFeatureSideEffect: Reducer {
    // MARK: State type that holds the state your feature needs to do its job, typically a struct
    struct State {
        var count = 0
        var fact: String?
        var isLoading = false
    }
    
    // MARK: Action type that holds all the actions the user can perform in the feature, typically an enum
    // TIP: It is best to name the Action cases after literally what the user does in the UI, such as incrementButtonTapped
    enum Action {
        case decrementButtonTapped
        case factButtonTapped
        case incrementButtonTapped
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .decrementButtonTapped:
            state.count -= 1
            state.fact = nil
            return .none
        case .factButtonTapped:
            state.fact = nil
            state.isLoading = true
            
            let (data, _) = try await URLSession.shared
                .data(from: URL(string: "http://numbersapi.com/\(state.count)")!)
            // 🛑 'async' call in a function that does not support concurrency
            // 🛑 Errors thrown from here are not handled
            
            state.fact = String(decoding: data, as: UTF8.self)
            state.isLoading = false
            
            return .none
        case .incrementButtonTapped:
            state.count += 1
            state.fact = nil
            return .none
        }
    }
}

// MARK: View stores require that State be Equatable
extension CounterFeatureSideEffect.State: Equatable {}
