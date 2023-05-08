//
//  EmptyPublisherView.swift
//  CombineApp
//
//  Created by Moroz Pavlo on 2023-01-23.
//

import SwiftUI
import Combine

struct EmptyPublisherView: View {
    
    @StateObject private var viewModel = EmptyFailurePublisherViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            List(viewModel.dataToView, id: \.self) { item in
                Text(item)
            }
            .font(.title)
        }
        .onAppear {
            viewModel.fetch()
        }
    }
}

class EmptyFailurePublisherViewModel: ObservableObject {
    
    @Published var dataToView: [String] = []
    
    let data = ["Value 1", "Value2", "Value 3", nil, "Value 5", "Value 6"]
    
    func fetch() {
        _ = data.publisher
            .flatMap { item -> AnyPublisher<String, Never> in
                if  let item = item {
                    return Just(item).eraseToAnyPublisher()
                } else {
                    return Empty(completeImmediately: true).eraseToAnyPublisher()
                }
            }
            .sink { [unowned self] item in
                dataToView.append(item)
            }
    }
}

struct EmptyPublisherView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyPublisherView()
    }
}
