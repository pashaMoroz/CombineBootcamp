//
//  CurrentValueSubjectView.swift
//  CombineApp
//
//  Created by Moroz Pavlo on 2023-01-23.
//

import SwiftUI
import Combine

struct CurrentValueSubjectView: View {
    @StateObject private var viewModel = CurrentValueSubjectViewModel()
    
    var body: some View {
        VStack {
            Text("\(viewModel.selectionSame.value ? "2 times" : "") \(viewModel.selection.value)")
                .foregroundColor(viewModel.selectionSame.value ? .red : .green)
                .padding()
            
            Button("Choose Cola") {
                viewModel.selection.value = "Cola"
            }
            .padding()
            
            Button("Choose Burger") {
                viewModel.selection.send("Burger")
            }
            .padding()
        }
    }
}

class CurrentValueSubjectViewModel: ObservableObject {
     var selection = CurrentValueSubject<String, Never>("Busket Empty")
     var selectionSame = CurrentValueSubject<Bool, Never>(false)
    
    var cancellable: Set<AnyCancellable> = []
    
    init() {
        selection
            .map { [unowned self] newValue -> Bool in
                if newValue == selection.value {
                    return true
                } else {
                    return false
                }
            }
            .sink { value in
                self.selectionSame.value = value
                self.objectWillChange.send()
            }
            .store(in: &cancellable)
    }
}

struct CurrentValueSubjectView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentValueSubjectView()
    }
}
