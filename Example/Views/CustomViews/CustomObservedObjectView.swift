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
      nestedObservableView
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
  
  // MARK: - Nested Observable Object
  
  @StateObject private var vm = CustomObservedObjectViewModel1()
  
  var nestedObservableView: some View {
    VStack(spacing: 8) {
      Text(vm.secondVM.text ?? "")
      
      Button("First") {
        vm.secondVM = .init("Value changed using parent \((0...20).randomElement() ?? 0)")
      }
      CustomObservedObjectView2(vm: vm.secondVM)
    }
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

// MARK: - Nested

struct CustomObservedObjectView2: View {
  
  @ObservedObject private var vm: CustomObservedObjectViewModel2
  
  init(vm: CustomObservedObjectViewModel2) {
    self.vm = vm
  }
  
  var body: some View {
    VStack {
      Text(vm.text ?? "")
      
      Button("Second") {
        vm.text = "Value changed using child \((0...20).randomElement() ?? 0)"
      }
    }
  }
}
fileprivate class CustomObservedObjectViewModel1: ObservableObject {
  
  @Published var text: String?
  @Published var secondVM: CustomObservedObjectViewModel2
  
  init(_ text: String? = "Example") {
    self.text = text
    self.secondVM = CustomObservedObjectViewModel2(text)
  }
}

class CustomObservedObjectViewModel2: ObservableObject {
  @Published var text: String? {
    didSet {
      print("Second: \(text ?? "")")
    }
  }
  
  init(_ text: String? = "Example") {
    self.text = text
  }
}
