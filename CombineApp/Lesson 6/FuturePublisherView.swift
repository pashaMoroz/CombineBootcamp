//
//  FuturePublisherView.swift
//  CombineApp
//
//  Created by Moroz Pavlo on 2023-01-30.
//

import SwiftUI
import Combine

struct FuturePublisherView: View {
    
    @StateObject var viewModel = FuturePublisherViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text(viewModel.firstResult)
            
            Button("Start") {
                viewModel.runAgain()
            }
            
            Text(viewModel.secondResult)
        }
        .font(.title)
        .onAppear {
            viewModel.fetch()
        }
    }
}

class FuturePublisherViewModel: ObservableObject {
    @Published var firstResult = ""
    @Published var secondResult = ""
    
    let futurePublisher = Future<String, Never> { promis in
        promis(.success("Future Publisher worked"))
        print("Future Publisher worked")
    }
       
    func fetch() {
        futurePublisher
            .assign(to: &$firstResult)
    }
              
    func runAgain() {
        futurePublisher
            .assign(to: &$secondResult)
    }
}

struct FuturePublisherView_Previews: PreviewProvider {
    static var previews: some View {
        FuturePublisherView()
    }
}
