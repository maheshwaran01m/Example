//
//  CustomObservedObjectView.swift
//  Example
//
//  Created by MAHESHWARAN on 12/10/23.
//

import SwiftUI
import Combine

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
  @Republished var secondVM: CustomObservedObjectViewModel2
  
  init(_ text: String? = "Example") {
    self.text = text
    self.secondVM = CustomObservedObjectViewModel2(text)
  }
}

class CustomObservedObjectViewModel2: ObservableObject {
  @Published var text: String?
  
  init(_ text: String? = "Example") {
    self.text = text
  }
}

@propertyWrapper
struct Republished<Obj: ObservableObject> {
  private var storage: Obj
  private var subscription: AnyCancellable? = nil
  
  init(wrappedValue: Obj) {
    self.storage = wrappedValue
  }
  
  @available(*, unavailable, message: "Republished can only be used inside reference types that conform to ObservableObject")
  var wrappedValue: Obj {
    get { fatalError() }
    set { fatalError() }
  }
  
  static subscript<EnclosingSelf: ObservableObject>(
    _enclosingInstance enclosing: EnclosingSelf,
    wrapped wrappedKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Obj>,
    storage storageKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Republished<Obj>>
  ) -> Obj where EnclosingSelf.ObjectWillChangePublisher == ObservableObjectPublisher {
    get {
      // Connect child's objectWillChange to parent's objectWillChange.
      if enclosing[keyPath: storageKeyPath].subscription == nil {
        let parentPublisher = enclosing.objectWillChange
        let childPublisher = enclosing[keyPath: storageKeyPath].storage.objectWillChange
        enclosing[keyPath: storageKeyPath].subscription = childPublisher.sink { _ in
          parentPublisher.send()
        }
      }
      return enclosing[keyPath: storageKeyPath].storage
    }
    set {
      // Cancel old child's connection to parent.
      if enclosing[keyPath: storageKeyPath].subscription != nil {
        enclosing[keyPath: storageKeyPath].subscription = nil
      }
      enclosing[keyPath: storageKeyPath].storage = newValue
      
      // Connect new child's objectWillChange to parent's objectWillChange.
      let parentPublisher = enclosing.objectWillChange
      let childPublisher = newValue.objectWillChange
      enclosing[keyPath: storageKeyPath].subscription = childPublisher.sink { _ in
        parentPublisher.send()
      }
      // Must tell parent explicitly that it has changed.
      parentPublisher.send()
    }
  }
}
