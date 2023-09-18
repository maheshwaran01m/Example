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
      viewHeight
      customBottomSheet
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
      .bottomSheet($showSheet) {
        Text("Hello")
      }
  }
}

struct CustomSheetView_Previews: PreviewProvider {
  static var previews: some View {
    CustomSheetView()
  }
}

struct BottomSheet<Content: View>: View {
  
  @Binding var isPresented: Bool
  var content: Content
  
  var body: some View {
    ZStack(alignment: .bottom) {
      if isPresented {
        Color.black.opacity(0.01)
          .ignoresSafeArea()
          .onTapGesture {
            isPresented.toggle()
          }
        content
          .transition(.move(edge: .bottom))
          .frame(maxWidth: .infinity, maxHeight: .infinity)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    .ignoresSafeArea()
    .animation(.easeInOut, value: isPresented)
  }
}

extension View {
  
  func bottomSheet<Content: View>(_ isPresented: Binding<Bool>,
                                  content: @escaping () -> Content) -> some View {
    self.overlay(BottomSheet(isPresented: isPresented, content: content()))
  }
}
