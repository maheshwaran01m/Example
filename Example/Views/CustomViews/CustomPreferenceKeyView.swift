//
//  CustomPreferenceKeyView.swift
//  Example
//
//  Created by MAHESHWARAN on 24/10/23.
//

import SwiftUI

struct CustomPreferenceKeyView: View {
  
  var body: some View {
    TabView {
      customSizeView
      customTitleView
        .tabViewStyle(.page)
    }
    .indexViewStyle(.page)
  }
  
  // MARK: - Custom Title
  @State private var textValue = "Hello World"
  
  var customTitleView: some View {
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
  
  // MARK: - Custom Size
  
  @State private var customSize = CGSize.zero
  
  var customSizeView: some View {
    VStack(spacing: 20) {
      Text("Hello World")
        .frame(width: customSize.width, height: customSize.height)
        .background(Color.blue.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 8))
      
      rectangleView
    }
    .onPreferenceChange(SizePreferenceKey.self) { customSize = $0 }
  }
  
  private var rectangleView: some View {
    HStack {
      Rectangle()
      
      GeometryReader { proxy in
        Rectangle()
          .clipShape(RoundedRectangle(cornerRadius: 8))
          .preference(key: SizePreferenceKey.self, value: proxy.size)
      }
      Rectangle()
    }
    .frame(height: 55)
  }
  
  
  // MARK: - SizePreferenceKey
  
  struct SizePreferenceKey: PreferenceKey {
    static var defaultValue = CGSize.zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
      value = nextValue()
    }
  }
}

#Preview {
  CustomPreferenceKeyView()
}
