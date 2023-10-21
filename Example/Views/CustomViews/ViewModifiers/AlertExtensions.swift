//
//  AlertExtensions.swift
//  Example
//
//  Created by MAHESHWARAN on 21/10/23.
//

import SwiftUI

protocol AlertView {
  var title: String { get }
  var message: String? { get }
  var actions: AnyView { get }
}

extension AlertView {
  
  var actions: AnyView {
    .init(Button("Ok"){ })
  }
}

extension View {
  
  func alert<T: AlertView>(_ item: Binding<T?>) -> some View {
    self.alert(
      item.wrappedValue?.title ?? "Error",
      isPresented: .init(item),
      actions: { item.wrappedValue?.actions },
      message: {
        if let message = item.wrappedValue?.message {
          Text(message)
        }
      })
  }
}
