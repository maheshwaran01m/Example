//
//  ViewModifiers.swift
//  Example
//
//  Created by MAHESHWARAN on 27/08/23.
//

import SwiftUI


public extension View {
  
  @ViewBuilder
  func isEnabled<Content: View>(_ show: Bool = true, _ content: (Self) -> Content) -> some View {
    if show {
      content(self)
    } else {
      self
    }
  }
  
  @ViewBuilder
  func overlayView<Content: View>(_ content: () -> Content)  -> some View {
    self.overlay(alignment: .topTrailing) {
      content()
        .alignmentGuide(.top) { $0[.top] + 8 }
        .alignmentGuide(.trailing) { $0[.trailing] - 8 }
    }
  }
  
  @ViewBuilder
  func borderView(_ shape: some Shape, width: CGFloat = 0, color: Color = .clear) -> some View {
    self
      .clipShape(shape)
      .overlay(shape.stroke(color, lineWidth: width))
  }
  
  func getHeight(_ height: Binding<CGFloat>) -> some View {
    self.background(
      GeometryReader { proxy in
        Color.clear
          .preference(key: HeightPreferenceKey.self, value: proxy.size.height)
      }
        .onPreferenceChange(HeightPreferenceKey.self) {
          height.wrappedValue = $0
        }
    )
  }
  
  // MARK: - Overlay sheet
  
  @ViewBuilder
  func overlaySheet<V: View>(isPresented: Binding<Bool>, @ViewBuilder content: () -> V) -> some View {
    modifier(OverlaySheet(isPresented: isPresented, contentView: content))
  }
  
  @ViewBuilder
  func clearbackgroundView(
    withColor color: Color,
    isClicked: (() -> Void)? = nil) -> some View {
      
    if #available(iOS 16.4, *) {
      self.presentationBackground {
          color
            .contentShape(Rectangle())
            .onTapGesture {
              isClicked?()
            }
        }
    } else {
      self.background(
        BackgroundColorView(color: color)
          .contentShape(Rectangle())
          .onTapGesture {
            isClicked?()
          }
      )
    }
  }
}
