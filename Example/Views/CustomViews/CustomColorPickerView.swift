//
//  CustomColorPickerView.swift
//  Examples
//
//  Created by MAHESHWARAN on 12/08/23.
//

import SwiftUI

struct CustomColorPickerView: View {
  
  @State private var bgColor = Color.white.opacity(0.3)
  
  var body: some View {
    ZStack {
      bgColor
    }
    .safeAreaInset(edge: .bottom) {
      ColorPicker("Set the background color", selection: $bgColor)
        .padding(10)
        .background(
          Color.secondary.opacity(0.2), in: RoundedRectangle(cornerRadius: 8))
    }
    
  }
}

struct CustomColorPickerView_Previews: PreviewProvider {
  static var previews: some View {
    CustomColorPickerView()
  }
}
