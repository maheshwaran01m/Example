//
//  CustomImageView.swift
//  Example
//
//  Created by MAHESHWARAN on 13/08/23.
//

import SwiftUI

struct CustomImageView: View {
  var body: some View {
    TabView {
      customImageAnimationView
      customImageColor
      customImageView
      systemImageView
      multiImageColor
      colorMultiplyView
    }
    .tabViewStyle(.page)
    .indexViewStyle(.page(backgroundDisplayMode: .always))
    .navigationBarTitleDisplayMode(.inline)
  }
  
  private var customImageView: some View {
    Image("water")
      .clipShape(Circle())
  }
  
  private var colorMultiplyView: some View {
    Image("water")
      .colorMultiply(.red)
      .scaledToFill()
  }
  
  private var systemImageView: some View {
    HStack {
      Image(systemName: "star")
        .renderingMode(.original)
      
      Image(systemName: "trash")
        .foregroundColor(.red)
    }
  }
  
  private var multiImageColor: some View {
    HStack {
      Image(systemName: "record.circle")
        .resizable()
        .symbolRenderingMode(.palette)
        .foregroundStyle(.red, .black)
        .frame(width: 40, height: 40)
      
      Image(systemName: "lasso.and.sparkles")
        .resizable()
        .symbolRenderingMode(.palette)
        .foregroundStyle(.red, .black)
        .frame(width: 40, height: 40)
    }
  }
  
  private var customImageColor: some View {
    VStack {
      Image(systemName: "heart")
        .renderingMode(.template)
        .font(.largeTitle)
        .foregroundStyle(Color.green)
      
      Image(systemName: "moon.stars")
        .renderingMode(.original)
        .font(.largeTitle)
        .foregroundStyle(Color.red)
      
      Image(systemName: "cloud.drizzle")
        .renderingMode(.template)
        .font(.largeTitle)
        .foregroundStyle(Color.primary, Color.blue)
    }
  }
}

extension CustomImageView {
  
  var customImageAnimations: [String] {
    (1...5).map { "landscape-0\($0)" }
  }
  
  private var customImageAnimationView: some View {
    GeometryReader { proxy in
      ScrollView(.horizontal) {
        
        HStack(spacing: 0) {
          ForEach(customImageAnimations, id: \.self) { item in
            GeometryReader { geometry in
              Image(item)
                .resizable()
                .scaledToFill()
                .frame(width: proxy.size.width)
                .offset(x: -geometry.frame(in: .global).origin.x)
                .clipped()
                .border(.red)
            }
            .frame(width: proxy.size.width)
          }
        }
      }
    }
  }
}

struct CustomImageView_Previews: PreviewProvider {
  static var previews: some View {
    CustomImageView()
  }
}
