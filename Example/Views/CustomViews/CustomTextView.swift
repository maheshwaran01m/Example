//
//  CustomTextView.swift
//  Example
//
//  Created by MAHESHWARAN on 13/08/23.
//

import SwiftUI

struct CustomTextView: View {
  
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
  }
}

struct CustomTextView_Previews: PreviewProvider {
  static var previews: some View {
    CustomTextView()
  }
}
