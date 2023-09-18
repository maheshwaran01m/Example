//
//  CustomSheetView.swift
//  Example
//
//  Created by MAHESHWARAN on 18/09/23.
//

import SwiftUI

struct CustomSheetView: View {
  
  @State private var isPresented = false
  @State private var height = CGFloat.zero
  
  var body: some View {
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
}

struct CustomSheetView_Previews: PreviewProvider {
  static var previews: some View {
    CustomSheetView()
  }
}
