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
      customImageColor
      customImageView
      systemImageView
      multiImageColor
      colorMultiplyView
    }
    .tabViewStyle(.page)
    .indexViewStyle(.page(backgroundDisplayMode: .always))
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

struct CustomImageView_Previews: PreviewProvider {
  static var previews: some View {
    CustomImageView()
  }
}
