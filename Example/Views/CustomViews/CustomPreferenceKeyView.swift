//
//  CustomPreferenceKeyView.swift
//  Example
//
//  Created by MAHESHWARAN on 24/10/23.
//

import SwiftUI

struct CustomPreferenceKeyView: View {
  
  @State private var textValue = "Hello World"
  
  var body: some View {
    VStack {
      SecondView(textValue)
    }
    .onPreferenceChange(TitlePreferenceKey.self) {
      self.textValue = $0
    }
  }
  
  struct SecondView: View {
    let textValue: String
    
    init(_ textValue: String) {
      self.textValue = textValue
    }
    
    var body: some View {
      Text(textValue)
        .preference(key: TitlePreferenceKey.self, value: "Hello Welcome")
    }
  }
  
  // MARK: - TitlePreferenceKey
  
  struct TitlePreferenceKey: PreferenceKey {
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
      value = nextValue()
    }
  }
}

#Preview {
  CustomPreferenceKeyView()
}
