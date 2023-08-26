//
//  CustomBottomView.swift
//  Example
//
//  Created by MAHESHWARAN on 23/08/23.
//

import SwiftUI

struct CustomBottomView: View {
  var body: some View {
    Text("Hello, World!")
  }
}

struct CustomBottomView_Previews: PreviewProvider {
  static var previews: some View {
    BottomSheet {
      CustomBottomView()
    }
  }
}

// MARK: - Bottom View

public struct BottomSheet<Content: View>: View {
  
  enum Style {
    case fullScreen, halfScreen, custom(CGFloat)
  }
  
  private let content: Content
  private var corners: UIRectCorner = .allCorners
  private var radius: CGFloat = 16//0.0
  private var style: Style = .halfScreen
  private var color: Color
  
  @State private var isPresented: Bool = false
  @State private var translation: CGSize = .zero
  @State private var offsetY: CGFloat = .zero
  
  
  init(color: Color = .gray.opacity(0.4),
       @ViewBuilder _ content: @escaping () -> Content) {
    self.color = color
    self.content = content()
  }
  
  public var body: some View {
    GeometryReader { proxy in
      mainView(proxy)
    }
  }
  
  private func mainView(_ proxy: GeometryProxy) -> some View {
    VStack(spacing: 8) {
      handleView
      content
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(color)
    .clipShape(RoundedRectangle(cornerRadius: radius))
    .offset(y: translation.height + offsetY)
    .gesture(dragGesture(proxy))
    .ignoresSafeArea(.container, edges: .bottom)
    .accessibilityElement(children: .contain)
  }
  
  private var handleView: some View {
    Rectangle()
      .fill(Color.gray.opacity(0.3))
      .cornerRadius(45)
      .frame(width: 68, height: 4)
      .padding(.top, 8)
  }
  
  private func dragGesture(_ proxy: GeometryProxy) -> some Gesture {
    DragGesture()
      .onChanged { value in
        translation = value.translation
      }
      .onEnded { value in
        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.9)) {
          let position = translation.height + offsetY
          let quarter = proxy.size.height / 4
          
          if position > quarter && position < quarter * 3 {
            offsetY = quarter * 2
          } else if position > quarter * 3 {
            offsetY = quarter * 3
          } else {
            offsetY = 0
          }
          translation = .zero
        }
      }
  }
}
