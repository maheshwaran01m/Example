//
//  OverlaySheet.swift
//  Example
//
//  Created by MAHESHWARAN on 27/09/23.
//

import SwiftUI

public struct OverlaySheet<V: View>: ViewModifier {
  
  @Binding var isPresented: Bool
  @Environment(\.horizontalSizeClass) var sizeClass
  private var contentView: V
  
  public init(isPresented: Binding<Bool>, 
              @ViewBuilder contentView: () -> V) {
    _isPresented = isPresented
    self.contentView = contentView()
  }
  
  public func body(content: Content) -> some View {
    content
      .sheet(isPresented: $isPresented) {
        contentView
          .clearbackgroundView(withColor: sizeClass == .compact ? .white : .clear) {
            isPresented = false
          }
      }
  }
}

struct BackgroundColorView: UIViewRepresentable {
  
  var color: Color
  
  init(color: Color) {
    self.color = color
  }

  func makeUIView(context: Context) -> UIView {
    let view = UIView()
    DispatchQueue.main.async {
      view.superview?.superview?.backgroundColor = .init(color)
    }
    return view
  }
  
  func updateUIView(_ uiView: UIView, context: Context) {}
}
