//
//  CustomBindingView.swift
//  Example
//
//  Created by MAHESHWARAN on 17/10/23.
//

import SwiftUI

struct CustomBindingView: View {
  
  @State private var textValue: String?
  
  var body: some View {
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
}

#Preview {
  CustomBindingView()
}
