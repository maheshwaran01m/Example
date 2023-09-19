//
//  CustomSheetView.swift
//  Example
//
//  Created by MAHESHWARAN on 18/09/23.
//

import SwiftUI

struct CustomSheetView: View {
  
  var body: some View {
    TabView {
      customBottomSheet
      viewHeight
    }
    .tabViewStyle(.page(indexDisplayMode: .always))
    .indexViewStyle(.page(backgroundDisplayMode: .always))
  }
  // MARK: - View Height
  
  @State private var isPresented = false
  @State private var height = CGFloat.zero
  
  var viewHeight: some View {
    Text("Hello, World!")
      .onTapGesture {
        isPresented.toggle()
      }
      .sheet(isPresented: $isPresented) {
        
        Text("Hello")
          .frame(width: 200, height: 200)
          .getHeight($height)
          .presentationDetents([.height(height)])
      }
  }
  
  // MARK: - Custom View
  
  @State private var showSheet = false
  
  var customBottomSheet: some View {
    Text("Hello, World!")
      .onTapGesture {
        showSheet.toggle()
      }
      .bottomSheetView($showSheet) {
        Text("Hello")
      }
  }
}

struct CustomSheetView_Previews: PreviewProvider {
  static var previews: some View {
    CustomSheetView()
  }
}

struct BottomSheetView<Content: View>: View {
  
  @Binding var isPresented: Bool
  @GestureState private var translation: CGFloat = 0
  
  private var content: Content
  private let maxHeight: BottomSheetHeight
  private let minHeight: BottomSheetHeight
  
  init(isPresented: Binding<Bool>,
       minHeight: BottomSheetHeight = .height(100),
       maxHeight: BottomSheetHeight = .fullScreen,
       content: @escaping () -> Content) {
    _isPresented = isPresented
    self.content = content()
    self.maxHeight = maxHeight
    self.minHeight = minHeight
  }
  
  var body: some View {
    GeometryReader { proxy in
      VStack(spacing: 0) {
        handle(for: proxy)
        contentView(for: proxy)
      }
      .frame(width: proxy.size.width, height: maxHeight(in: proxy), alignment: .top)
      .background(.orange.opacity(0.1))
      .clipShape(RoundedRectangle(cornerRadius: 16))
      .frame(height: proxy.size.height + proxy.safeAreaInsets.bottom, 
             alignment: .bottom)
      .offset(y: max(offset(for: proxy) + translation, 0))
      .transition(.move(edge: .bottom))
    }
  }
  
  
  func contentView(for proxy: GeometryProxy) -> some View {
    content
      .padding(.bottom, proxy.safeAreaInsets.bottom)
  }
  
  func handle(for proxy: GeometryProxy) -> some View {
    VStack(spacing: 10) {
      handleView
      Divider()
        .frame(maxWidth: .infinity)
    }
    .background(Color.blue.opacity(0.1))
    .onTapGesture {
      isPresented.toggle()
    }
    .gesture(dragGesture(proxy))
  }
  
  private func dragGesture(_ proxy: GeometryProxy) -> some Gesture {
    DragGesture()
      .updating($translation) { value, state, _ in
        state = value.translation.height
      }
      .onEnded { value in
        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.9)) {
          let height = abs(value.translation.height)
          let ratio: CGFloat = 0.25
          let distance = maxHeight(in: proxy) * ratio
          let apply = height > distance
          guard apply else { return }
          isPresented = value.translation.height < 0
        }
      }
  }
  
  
  private var handleView: some View {
    Rectangle()
      .fill(Color.gray.opacity(0.3))
      .cornerRadius(45)
      .frame(width: 68, height: 4)
      .padding(.top, 8)
  }
  
  
  func height(of height: BottomSheetHeight, in proxy: GeometryProxy) -> CGFloat {
    switch height {
    case .fullScreen:
      return proxy.size.height + proxy.safeAreaInsets.bottom
    case .percentage(let ratio):
      return ratio * (proxy.size.height + proxy.safeAreaInsets.bottom)
    case .height(let height):
      return height
    }
  }
  
  func minHeight(in geo: GeometryProxy) -> CGFloat {
      height(of: minHeight, in: geo)
  }
  
  func maxHeight(in geo: GeometryProxy) -> CGFloat {
      height(of: maxHeight, in: geo)
  }
  
  func offset(for proxy: GeometryProxy) -> CGFloat {
    isPresented ? 0 : maxHeight(in: proxy) - minHeight(in: proxy)
  }
  
  enum BottomSheetHeight {
    case fullScreen
    case percentage(CGFloat)
    case height(CGFloat)
  }
}

extension View {
  
  @ViewBuilder
  func bottomSheetView<Content: View>(
    _ isPresented: Binding<Bool>,
    minHeight: BottomSheetView<Content>.BottomSheetHeight = .height(250),
    maxHeight: BottomSheetView<Content>.BottomSheetHeight = .percentage(0.8),
    content: @escaping () -> Content) -> some View {
        ZStack {
          self
          BottomSheetView(isPresented: isPresented,
                      minHeight: minHeight,
                      maxHeight: maxHeight,
                      content: content)
        }
    }
}
