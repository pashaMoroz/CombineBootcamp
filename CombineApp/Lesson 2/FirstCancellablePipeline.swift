//
//  FirstCancellablePipeline.swift
//  CombineApp
//
//  Created by Moroz Pavlo on 2023-01-23.
//

import SwiftUI
import Combine

struct FirstCancellablePipeline: View {
    
    @StateObject var viewModel = FirstCancellablePipelineViewModel()
    
    var body: some View {
        
        VStack {
            Spacer()
            Text(viewModel.data)
                .font(.title)
                .foregroundColor(.green)
            
            Text(viewModel.status)
                .foregroundColor(.blue)
            Spacer()
            Button {
                viewModel.cancel()
            } label: {
                Text("Canceled surscribe")
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
            }
            .background(.red)
            .cornerRadius(8)
            .opacity(viewModel.status == "Request to bank" ? 1.0 : 0.0)
            
            Button {
                viewModel.refresh()
            } label: {
                Text("Request data")
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
            }
            .background(.blue)
            .cornerRadius(8)
            .padding()
        }
    }
    
    class FirstCancellablePipelineViewModel: ObservableObject {
        @Published var data = ""
        @Published var status = ""
        
        private var cancallable: AnyCancellable?
        
        init() {
            cancallable = $data
                .map { [unowned self] value -> String in
                    status = "Request to bank"
                    return value
                }
                .delay(for: 5, scheduler: DispatchQueue.main)
                .sink { [unowned self] value in
                    self.data = "Balance 1.000$"
                    self.status = "Data recived"
                }
        }
        
        func refresh() {
            data = "Request again"
        }
        
        func cancel() {
            status = "Operation is canceled"
            cancallable?.cancel()
            cancallable = nil
        }
    }
}
    
    struct FirstCancellablePipeline_Previews: PreviewProvider {
        static var previews: some View {
            FirstCancellablePipeline()
        }
    }

