//
//  CounterFeature.swift
//  ComposableArchitecture-Sample
//
//  Created by Tiago Oliveira on 12/11/23.
//

import ComposableArchitecture

struct CounterFeature: Reducer {
    // MARK: State type that holds the state your feature needs to do its job, typically a struct
    struct State {
        var count = 0
    }
    
    // MARK: Action type that holds all the actions the user can perform in the feature, typically an enum
    // TIP: It is best to name the Action cases after literally what the user does in the UI, such as incrementButtonTapped
    enum Action {
        case decrementButtonTapped
        case incrementButtonTapped
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .decrementButtonTapped:
            state.count -= 1
            return .none
        case .incrementButtonTapped:
            state.count += 1
            return .none
        }
    }

}
