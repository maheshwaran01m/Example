//
//  CustomObservedObjectView.swift
//  Example
//
//  Created by MAHESHWARAN on 12/10/23.
//

import SwiftUI

struct CustomObservedObjectView: View {
  
  var body: some View {
    TabView {
      exampleUsingStateObject
    }
    .tabViewStyle(.page)
    .indexViewStyle(.page(backgroundDisplayMode: .never))
  }
  
  
  // MARK: - StateObject
  
  @StateObject private var viewModel = CustomObservedObjectViewModelOne()
  @StateObject private var searchVM = CustomObservedObjectViewModelTwo()
  
  var exampleUsingStateObject: some View {
    VStack {
      Text(searchVM.searchText ?? "")
        .bold()
      
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
