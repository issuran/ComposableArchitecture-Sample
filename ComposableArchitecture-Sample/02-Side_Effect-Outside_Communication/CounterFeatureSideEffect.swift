//
//  CounterFeatureSideEffect.swift
//  ComposableArchitecture-Sample
//
//  Created by Tiago Oliveira on 13/11/23.
//

import ComposableArchitecture
import SwiftUI

//@Reducer
struct CounterFeatureSideEffect: Reducer {
    // MARK: State type that holds the state your feature needs to do its job, typically a struct
    struct State: Equatable {
        var count = 0
        var fact: String?
        var isLoading = false
        var isTimerRunning = false
    }
    
    // MARK: Action type that holds all the actions the user can perform in the feature, typically an enum
    // TIP: It is best to name the Action cases after literally what the user does in the UI, such as incrementButtonTapped
    enum Action {
        case decrementButtonTapped
        case factButtonTapped
        case incrementButtonTapped
        case factResponse(String)
        case toggleTimerButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .decrementButtonTapped:
                state.count -= 1
                state.fact = nil
                return .none
                
            case .factButtonTapped:
                state.fact = nil
                state.isLoading = true
                
                // MARK: This provides you with an asynchronous context to perform any kind of work you want, as well as a handle (send) for sending actions back into the system.
//                return .run { send in
//                    // ✅ Do async work in here, and send actions back into the system.
//                }
                
                return .run { [count = state.count] send in
                    let (data, _) = try await URLSession.shared
                      .data(from: URL(string: "http://numbersapi.com/\(count)")!)
                    let fact = String(decoding: data, as: UTF8.self)
                    
                    // state.fact = fact
                    
                    // 🛑 Mutable capture of 'inout' parameter 'state' is not allowed in
                    //    concurrently-executing code
                    
                    // instead we should do:
                    await send(.factResponse(fact))
                }
                
            case let .factResponse(fact):
                state.fact = fact
                state.isLoading = false
                return .none
                
            case .incrementButtonTapped:
                state.count += 1
                state.fact = nil
                return .none
                
            case .toggleTimerButtonTapped:
                return .none
            }
        }
    }
}
