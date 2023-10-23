//
//  CustomMaskView.swift
//  Example
//
//  Created by MAHESHWARAN on 23/10/23.
//

import SwiftUI

struct CustomMaskView: View {
  
  @State private var rating: Int = 4

  var body: some View {
    ZStack {
      starsView
        .overlay(content: maskView)
    }
  }
  
  private var starsView: some View {
    HStack {
      ForEach(1..<6) { index in
        Image(systemName: "star.fill")
          .font(.largeTitle)
          .foregroundStyle(.gray)
//          .foregroundStyle(rating >= index ? .yellow : .gray)
          .onTapGesture {
            withAnimation(.easeInOut) {
              rating = index
            }
          }
      }
    }
  }
  
  private func maskView() -> some View {
    GeometryReader { proxy in
      ZStack(alignment: .leading) {
        Rectangle()
          .foregroundStyle(.yellow)
          .frame(width: CGFloat(rating) / 5 *  proxy.size.width)
      }
    }
    .mask(starsView)
    .allowsHitTesting(false)
  }


}

#Preview {
  CustomMaskView()
}
