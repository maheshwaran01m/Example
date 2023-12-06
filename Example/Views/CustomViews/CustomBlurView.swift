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
      shadowView
      blurViewOne
      imageBlurView
    }
    .tabViewStyle(.page)
    .indexViewStyle(.page(backgroundDisplayMode: .always))
    .ignoresSafeArea(.container)
  }
  
  // MARK: - Background Blur
  private var blurViewOne: some View {
    ZStack {
      Color.blue
        .blur(radius: 16)
    }
  }
  
  // MARK: - ImageBlur
  
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
  
  private var shadowView: some View {
    VStack(spacing: 80) {
      RoundedRectangle(cornerRadius: 8)
        .fill(Color.cyan)
        .frame(width: 120, height: 100)
        .shadow(color: .primary.opacity(0.7), radius: 5, x: 15, y: 20)
      
      RoundedRectangle(cornerRadius: 8)
        .fill(Color.cyan)
        .frame(width: 120, height: 100)
        .shadow(color: .primary.opacity(0.7), radius: 5, x: -15, y: -20)
    }
  }
}

struct CustomBlurView_Previews: PreviewProvider {
  static var previews: some View {
    CustomBlurView()
  }
}
