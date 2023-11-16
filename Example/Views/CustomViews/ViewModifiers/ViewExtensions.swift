//
//  ViewExtensions.swift
//  Example
//
//  Created by MAHESHWARAN on 15/10/23.
//

import SwiftUI

extension Binding where Value == Bool {
  
  init<T>(_ value: Binding<T?>) {
    self.init {
      value.wrappedValue != nil
    } set: { newValue in
      if !newValue {
        value.wrappedValue = nil
      }
    }
  }
}

// MARK: - Hashable

struct ExampleForHashable: Hashable {
  let title: String
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(title)
  }
}
