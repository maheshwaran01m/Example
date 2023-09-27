//
//  CustomOverlaySheetView.swift
//  Example
//
//  Created by MAHESHWARAN on 27/09/23.
//

import SwiftUI

struct CustomOverlaySheetView: View {
  
  @State private var isPresented = false
  
  var body: some View {
    Text("Hello, World!")
      .onTapGesture {
        isPresented.toggle()
      }
      .overlaySheet(isPresented: $isPresented) {
        Text("Hello sheet")
          .frame(width: 200, height: 200)
          .background(.background)
          .presentationDetents([.height(200)])
      }
  }
}

#Preview {
  CustomOverlaySheetView()
}
