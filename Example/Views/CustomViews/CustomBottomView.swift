//
//  CustomBottomView.swift
//  Example
//
//  Created by MAHESHWARAN on 23/08/23.
//

import SwiftUI

struct CustomBottomView: View {
  @State private var isPresented = false
  
  var body: some View {
    Text("Hello, World!")
      .onTapGesture {
        isPresented.toggle()
      }
      .bottomSheet(isPresented: $isPresented) {
        Text("Sheet View")
      }
      .navigationBarTitleDisplayMode(.inline)
  }
}

struct CustomBottomView_Previews: PreviewProvider {
  
  
  static var previews: some View {
    @State var isPresented = true
    
    Text("Hello, World!")
      .onTapGesture {
        isPresented.toggle()
      }
      .bottomSheet(isPresented: $isPresented) {
        Text("Sheet View")
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
  private var radius: CGFloat
  private var style: Style
  private var color: Color
  
  @State private var isPresented: Bool = false
  @State private var translation: CGSize = .zero
  @State private var offsetY: CGFloat = .zero
  
  
  init(style: Style = .halfScreen,
       color: Color = .gray.opacity(0.4),
       radius: CGFloat = 16.0,
       @ViewBuilder content: @escaping () -> Content) {
    self.style = style
    self.color = color
    self.radius = radius
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
    .frame(maxWidth: proxy.size.width, maxHeight: proxy.size.height, alignment: .top)
    .background(color)
    .clipShape(RoundedRectangle(cornerRadius: radius))
    .offset(y: max(translation.height + offsetY, 0))
    .frame(height: proxy.size.height + proxy.safeAreaInsets.bottom,
           alignment: .bottom)
    .gesture(dragGesture(proxy))
    .ignoresSafeArea(.container, edges: .bottom)
    .accessibilityElement(children: .contain)
  }
  
  private var handleView: some View {
    Rectangle()
      .fill(Color.gray.opacity(0.8))
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

extension View {
  
  @ViewBuilder
  func bottomSheet<Content: View>(
    isPresented: Binding<Bool>,
    style: BottomSheet<Content>.Style = .custom(100),
    background color: Color = .pink.opacity(0.2),
    cornerRadius radius: CGFloat = 16,
    @ViewBuilder content: @escaping () -> Content) -> some View {
      
      if isPresented.wrappedValue {
        ZStack {
          self
            .onTapGesture {
              isPresented.wrappedValue.toggle()
            }
          BottomSheet(style: style, color: color, radius: radius, content: content)
        }
      } else {
        self
      }
    }
}
