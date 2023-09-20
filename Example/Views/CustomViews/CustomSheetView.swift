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
    .ignoresSafeArea(.container, edges: .bottom)
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
          .frame(height: 100)
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
  @State private var minHeight: CGFloat = 0
  
  private var content: Content
  private let maxHeight: BottomSheetHeight
  
  init(isPresented: Binding<Bool>,
       maxHeight: BottomSheetHeight = .fullScreen,
       content: @escaping () -> Content) {
    _isPresented = isPresented
    self.content = content()
    self.maxHeight = maxHeight
  }
  
  var body: some View {
    GeometryReader { proxy in
      VStack(spacing: 8) {
        handleView
        content
      }
      .getHeight($minHeight)
      .frame(width: proxy.size.width, height: maxHeight(in: proxy), alignment: .top)
      .background(Color.gray.opacity(0.1))
      .clipShape(RoundedRectangle(cornerRadius: 16))
      .offset(y: max(offset(for: proxy) + translation, 0))
      .frame(height: proxy.size.height + proxy.safeAreaInsets.bottom,
             alignment: .bottom)
      .gesture(dragGesture(proxy))
      .ignoresSafeArea(.container, edges: .bottom)
      .transition(.move(edge: .bottom))
    }
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
      .updating($translation) { value, state, _ in
        state = value.translation.height
      }
      .onEnded { value in
        let height = abs(value.translation.height)
        let distance = maxHeight(in: proxy) * CGFloat(0.25)
        let apply = height > distance
        guard apply else { return }
        isPresented = value.translation.height < 0
      }
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
  
  func maxHeight(in geo: GeometryProxy) -> CGFloat {
    height(of: maxHeight, in: geo)
  }
  
  func offset(for proxy: GeometryProxy) -> CGFloat {
    isPresented ? 0 : maxHeight(in: proxy) - minHeight
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
    maxHeight: BottomSheetView<Content>.BottomSheetHeight = .percentage(0.9),
    content: @escaping () -> Content) -> some View {
      
      ZStack {
        self
          .onTapGesture {
            isPresented.wrappedValue = false
          }
        BottomSheetView(isPresented: isPresented,
                        maxHeight: maxHeight,
                        content: content)
      }
    }
}
