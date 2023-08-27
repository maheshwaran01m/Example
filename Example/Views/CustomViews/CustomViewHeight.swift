//
//  CustomViewHeight.swift
//  Example
//
//  Created by MAHESHWARAN on 20/08/23.
//

import SwiftUI

struct CustomViewHeight: View {
  
  @State private var bottomHeight: CGFloat = 0.0 {
    didSet {
      print("Heigth: \(bottomHeight)")
    }
  }
  
  var body: some View {
    VStack {
      titleView
      titleViewOne
    }
  }
  
  private var titleView: some View {
    Text("Hello, World!")
      .font(.title)
  }
  
  private var titleViewOne: some View {
    Text("Hello, World!")
      .font(.title)
      .bold()
      .padding(10)
      .foregroundColor(Color.primary)
      .background(Color.gray.opacity(0.2), in: Capsule())
      .getHeight($bottomHeight)
  }
}

struct CustomBackgroundHeightView_Previews: PreviewProvider {
  static var previews: some View {
    CustomViewHeight()
  }
}
