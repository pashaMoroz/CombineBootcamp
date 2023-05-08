//
//  CancellingMultiplePipelines.swift
//  CombineApp
//
//  Created by Moroz Pavlo on 2023-01-23.
//

import SwiftUI
import Combine

struct CancellingMultiplePipelines: View {
    @StateObject private var viewModel = CancellingMultiplePipelinesViewModel()
    var body: some View {
        Group {
            HStack {
                TextField("Name", text: $viewModel.firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text(viewModel.firstNameValidation)
            }
            HStack {
                TextField("Last Name", text: $viewModel.lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text(viewModel.lastNameValidation)
            }
        }
        .padding()
        Button("Cancel Validation") {
            viewModel.cancelAllValidations()
        }

    }
}

class CancellingMultiplePipelinesViewModel: ObservableObject {
    
    @Published var firstName: String = ""
    @Published var firstNameValidation: String = ""
    
    @Published var lastName: String = ""
    @Published var lastNameValidation: String = ""
    
    private var validationCancellables: Set<AnyCancellable> = []
    
    init() {
        $firstName
            .map { $0.isEmpty ? "❌" : "✅" }
            .sink { [unowned self] value in
                self.firstNameValidation = value
            }
            .store(in: &validationCancellables)
        
        $lastName
            .map { $0.isEmpty ? "❌" : "✅" }
            .sink { [unowned self] value in
                self.lastNameValidation = value
            }
            .store(in: &validationCancellables)
    }
    
    func cancelAllValidations() {
        firstNameValidation = ""
        lastNameValidation = ""
        validationCancellables.removeAll()
    }
}

struct CancellingMultiplePipelines_Previews: PreviewProvider {
    static var previews: some View {
        CancellingMultiplePipelines()
    }
}
