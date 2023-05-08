//
//  FirstPipeline.swift
//  CombineApp
//
//  Created by Moroz Pavlo on 2023-01-23.
//

import SwiftUI
import Combine

struct FirstPipeline: View {
    
    @StateObject var viewModel = FirstPipelineViewModel()
    
    var body: some View {
        HStack {
            TextField("Your name", text: $viewModel.name)
                .textFieldStyle(.roundedBorder)
                .padding()
            Text(viewModel.validation)
        }
        .padding()
    }
}

class FirstPipelineViewModel: ObservableObject {
    @Published var name = ""
    @Published var validation = ""
    
    init() {
        $name.map {  $0.isEmpty ? "❌" : "✅" }
            .assign(to: &$validation)
    }
}

struct FirstPipeline_Previews: PreviewProvider {
    static var previews: some View {
        FirstPipeline()
    }
}
