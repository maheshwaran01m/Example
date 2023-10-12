//
//  CustomObservedObjectView.swift
//  Example
//
//  Created by MAHESHWARAN on 12/10/23.
//

import SwiftUI

struct CustomObservedObjectView: View {
  
  @StateObject private var viewModel = CustomObservedObjectViewModelOne()
  @StateObject private var searchVM = CustomObservedObjectViewModelTwo()
  
  var body: some View {
    VStack {
      Text(searchVM.searchText ?? "")
      
      TextField("Enter", text: $viewModel.value)
        .textFieldStyle(.roundedBorder)
        .onChange(of: viewModel.value) { _ in
          viewModel.searchText($searchVM)
        }
    }
    .padding(.horizontal)
  }
}

#Preview {
  CustomObservedObjectView()
}

private class CustomObservedObjectViewModelOne: ObservableObject {
  @Published var value = String()
  
  func searchText(_ search: ObservedObject<CustomObservedObjectViewModelTwo>.Wrapper) {
    search.searchText.wrappedValue = value
  }
}

private class CustomObservedObjectViewModelTwo: ObservableObject {
  @Published var searchText: String?
}
