//
//  CustomBindingView.swift
//  Example
//
//  Created by MAHESHWARAN on 17/10/23.
//

import SwiftUI

struct CustomBindingView: View {
  
  var body: some View {
    TabView {
      customBindingView
      customAlertView
    }
    .tabViewStyle(.page)
    .indexViewStyle(.page(backgroundDisplayMode: .never))
  }
  
  @State private var textValue: String?
  
  var customBindingView: some View {
    VStack {
      Text(textValue ?? "")
      exampleBindingView
      
      Button("Show") {
        if !(textValue?.isEmpty ?? false) {
          self.textValue = ""
        } else {
          self.textValue = "Enter Text"
        }
      }
    }
  }
  
  @ViewBuilder
  var exampleBindingView: some View {
    if let bindingValue = Binding($textValue) {
      TextField("Enter Value", text: bindingValue)
        .textFieldStyle(.roundedBorder)
        .keyboardType(.default)
        .submitLabel(.next)
    }
  }
  
  @State private var showingAlert: String?
  
  var customAlertView: some View {
    Button("Show Alert") {
      showingAlert = "Example alert"
    }
    .alert("Important message", isPresented: .init($showingAlert)) {
      Button("Delete", role: .destructive) { }
      Button("Cancel", role: .cancel) { }
    }
  }
}

#Preview {
  CustomBindingView()
}
