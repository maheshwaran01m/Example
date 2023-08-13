//
//  CustomScrollView.swift
//  Examples
//
//  Created by MAHESHWARAN on 07/08/23.
//

import SwiftUI

struct CustomScrollView: View {
  
  var body: some View {
    TabView {
      verticalScroll
      hortizonalScroll
    }
    .tabViewStyle(.page)
    .indexViewStyle(.page(backgroundDisplayMode: .always))
  }
  
  private var verticalScroll: some View {
    ScrollView(showsIndicators: true) {
      ForEach(0..<50, id: \.self) { i in
        Text("Example \(i)")
          .padding(5)
          .background(.gray.opacity(0.2))
      }
    }
  }
  
  private var hortizonalScroll: some View {
    ScrollView(.horizontal, showsIndicators: true) {
      HStack {
        ForEach(0..<23, id: \.self) { i in
          Text("Example \(i)")
            .padding(5)
            .background(.gray.opacity(0.2))
        }
      }
    }
  }
}

struct CustomScrollView_Previews: PreviewProvider {
  static var previews: some View {
    CustomScrollView()
  }
}
