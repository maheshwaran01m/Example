//
//  CustomPropertyWrapper.swift
//  Example
//
//  Created by MAHESHWARAN on 01/09/23.
//

import SwiftUI

struct CustomPropertyWrapper: View {
  @StringFormat(format: .lowercased) private var text = ""
  
  var body: some View {
    VStack {
      Text(text)
      TextField("Enter", text: $text)
    }
  }
}

struct CustomPropertyWrapper_Previews: PreviewProvider {
  static var previews: some View {
    CustomPropertyWrapper()
  }
}

// MARK: - StringFormat

@propertyWrapper
struct StringFormat: DynamicProperty {
  
  @State private var value: String = ""
  private var format: Format = .default
  
  enum Format {
    case lowercased, uppercased, capitalized, `default`
  }
  init(wrappedValue: String, format: Format = .default) {
    self.wrappedValue = wrappedValue
    self.format = format
  }
  
  var wrappedValue: String {
    get { value }
    nonmutating set { value = formattedString(newValue) }
  }
  
  var projectedValue: Binding<String> {
    Binding(
      get: { wrappedValue },
      set: { wrappedValue = $0 }
    )
  }
  
  private func formattedString(_ string: String) -> String {
    switch format {
    case .capitalized:
      return string.capitalized
    case .lowercased:
      return string.lowercased()
    case .uppercased:
      return string.uppercased()
    case .default:
      return string
    }
  }
}
