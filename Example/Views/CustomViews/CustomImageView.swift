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
}

struct CustomImageView_Previews: PreviewProvider {
  static var previews: some View {
    CustomImageView()
  }
}
