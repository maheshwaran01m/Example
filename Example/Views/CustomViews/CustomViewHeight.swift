//
//  CustomViewHeight.swift
//  Example
//
//  Created by MAHESHWARAN on 20/08/23.
//

import SwiftUI

struct CustomViewHeight: View {
  
  @State private var bottomHeight: CGFloat = 0.0 {
    didSet {
      print("Heigth: \(bottomHeight)")
    }
  }
  
  var body: some View {
    VStack {
      titleView
      titleViewOne
    }
  }
  
  private var titleView: some View {
    Text("Hello, World!")
      .font(.title)
  }
  
  private var titleViewOne: some View {
    Text("Hello, World!")
      .font(.title)
      .bold()
      .padding(10)
      .foregroundColor(Color.primary)
      .background(Color.gray.opacity(0.2), in: Capsule())
      .getHeight(Color.clear) {
        bottomHeight = $0
      }
  }
}

struct CustomBackgroundHeightView_Previews: PreviewProvider {
  static var previews: some View {
    CustomViewHeight()
  }
}

// MARK: - PreferenceKey

public struct FloatPreferenceKey: PreferenceKey {
  public typealias Value = CGFloat
  public static var defaultValue: CGFloat = 0.0
    
  public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value += nextValue()
  }
}

public extension View {
  
  func getHeight(_ color: Color, content: @escaping (CGFloat) -> Void) -> some View {
    self.background(
      GeometryReader { proxy in
        color
          .preference(key: FloatPreferenceKey.self, value: proxy.size.height)
      }
        .onPreferenceChange(FloatPreferenceKey.self) {
          content($0)
        }
    )
  }
}
