//
//  CustomStackView.swift
//  Example
//
//  Created by MAHESHWARAN on 13/08/23.
//

import SwiftUI

struct CustomStackView: View {
  var body: some View {
    TabView {
      vStack
      hStack
      zStack
      lazyVStack
      lazyHStack
    }
    .tabViewStyle(.page)
    .indexViewStyle(.page(backgroundDisplayMode: .always))
  }
  
  private var vStack: some View {
    // VStack – a vertical stack of views
    VStack {
      Text("Hello, world!")
      Text("This is inside a stack")
    }
    .border(.bar)
  }
  
  private var hStack: some View {
    // HStack – a horizontal stack of views
    HStack(spacing: 20) {
        Text("Hello, world!")
        Text("This is inside a stack")
    }
  }
  
  private var zStack: some View {
    //  ZStack for arranging things by depth – it makes views that overlap
    ZStack {
      Color.red.opacity(0.1)
        Text("This is inside a stack")
    }
  }
  
  private var lazyVStack: some View {
    // Take entire available vertical space
    LazyVStack {
      Text("Hello, world!")
      Text("This is inside a stack")
    }
    .border(.red)
  }
  
  private var lazyHStack: some View {
    // Take entire available horizontal space
    LazyHStack {
      Text("Hello, world!")
      Text("This is inside a stack")
    }
    .border(.red)
  }
}

struct CustomStackView_Previews: PreviewProvider {
  static var previews: some View {
    CustomStackView()
  }
}
