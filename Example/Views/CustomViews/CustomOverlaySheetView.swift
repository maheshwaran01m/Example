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
        VStack {
          Text("Hello sheet")
            .frame(width: 200, height: 100)
            .background(.background)
          Text("Hello sheet")
            .frame(width: 200, height: 100)
            .background(.background)
          Text("Hello sheet")
            .frame(width: 200, height: 100)
            .background(.background)
        }
      }
  }
}

#Preview {
  CustomOverlaySheetView()
}
