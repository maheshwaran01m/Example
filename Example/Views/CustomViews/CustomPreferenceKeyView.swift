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
      framePreferenceKeyView
      customSizeView
      customTitleView
    }
    .tabViewStyle(.page)
    .indexViewStyle(.page(backgroundDisplayMode: .always))
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
  
  // MARK: - Frame Preference Key
  
  @State private var framePreferenceValue: String?
  
  var framePreferenceKeyView: some View {
    Text("Content")
      .frame(width: 320, height: 320)
      .background(backgroundView)
      .overlay(alignment: .bottom, content: frameOverlayView)
  }
  
  private var backgroundView: some View {
    GeometryReader {
      Color.clear
        .preference(key: FramePreferenceKey.self, value: $0.frame(in: .global))
        .onPreferenceChange(FramePreferenceKey.self) {
          framePreferenceValue = "X: \($0.minX), Y: \($0.minY), \nWidth: \($0.width), Height: \($0.height)"
          print("Rect: \($0)")
        }
    }
  }
  
  private func frameOverlayView() -> some View {
    Text(framePreferenceValue ?? "")
  }
  
  struct FramePreferenceKey: PreferenceKey {
    static var defaultValue = CGRect.zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
      value = nextValue()
    }
  }
}

#Preview {
  CustomPreferenceKeyView()
}
