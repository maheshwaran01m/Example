//
//  CustomColorView.swift
//  Examples
//
//  Created by MAHESHWARAN on 06/08/23.
//

import SwiftUI

struct CustomColorView: View {
  var body: some View {
    TabView {
     colorView
      vStackColorView
      zStackColorView
    }
    .tabViewStyle(.page)
    .indexViewStyle(.page(backgroundDisplayMode: .always))
  }
  
  private var colorView: some View {
    ZStack {
      Text("Your content")
    }
    .background(.red)
  }
  
  private var vStackColorView: some View {
    VStack {
      Color.red.opacity(0.6)
          .frame(width: 200, height: 200)
      
      Color.black.opacity(0.4)
        .frame(minWidth: 200, maxWidth: .infinity, maxHeight: 200)
    }
    .clipShape(RoundedRectangle(cornerRadius: 16))
    .padding(10)
  }
  
  private var zStackColorView: some View {
    ZStack {
      Color.red.opacity(0.2)
        Text("Your content")
    }
    .ignoresSafeArea()
  }
}

struct CustomColorView_Previews: PreviewProvider {
  static var previews: some View {
    CustomColorView()
  }
}
