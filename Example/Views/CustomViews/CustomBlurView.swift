//
//  CustomBlurView.swift
//  Examples
//
//  Created by MAHESHWARAN on 12/08/23.
//

import SwiftUI

struct CustomBlurView: View {
  
  var body: some View {
    TabView {
      blurViewOne
      imageBlurView
    }
    .tabViewStyle(.page)
    .indexViewStyle(.page(backgroundDisplayMode: .always))
    .ignoresSafeArea(.container)
  }
  
  // Background Blur
  private var blurViewOne: some View {
    ZStack {
      Color.blue
        .blur(radius: 16)
    }
  }
  
  // ImageBlur
  
  var imageBlurView: some View {
    ZStack {
      Color.red
        .frame(width: 300, height: 300)
        .blur(radius: 16)
      
      Image("water")
        .resizable()
        .scaledToFit()
        .frame(width: 200, height: 200)
    }
  }
}

struct CustomBlurView_Previews: PreviewProvider {
  static var previews: some View {
    CustomBlurView()
  }
}
