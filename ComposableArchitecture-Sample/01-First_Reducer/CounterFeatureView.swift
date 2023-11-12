//
//  CounterFeatureView.swift
//  ComposableArchitecture-Sample
//
//  Created by Tiago Oliveira on 12/11/23.
//

import ComposableArchitecture
import SwiftUI

struct CounterFeatureView: View {
    
    // MARK: Store represents the runtime of your feature. That is, it is the object that can process actions in order to update state, and it can execute effects and feed data from those effects back into the system
    let store: StoreOf<CounterFeature>
    
    var body: some View {
        // MARK: WithViewStore that provides a lightweight syntax for constructing a view store.
        // Used for observing state in the store
        // WARNING: Currently we are observing all state in the store by using observe: { $0 }, but typically features hold onto a lot more state than what is needed in the view. Check Performance(https://pointfreeco.github.io/swift-composable-architecture/main/documentation/composablearchitecture/performance)
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Text("\(viewStore.count)")
                    .font(.largeTitle)
                    .padding()
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
                HStack {
                    Button("-") {
                        viewStore.send(.decrementButtonTapped)
                    }
                    .font(.largeTitle)
                    .padding()
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
                    
                    Button("+") {
                        viewStore.send(.incrementButtonTapped)
                    }
                    .font(.largeTitle)
                    .padding()
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
                }
            }
        }
    }
}

struct CounterFeatureViewPreview: PreviewProvider {
    static var previews: some View {
        CounterFeatureView(
            store: Store(initialState: CounterFeature.State()) {
                CounterFeature()
            }
        )
    }
}
