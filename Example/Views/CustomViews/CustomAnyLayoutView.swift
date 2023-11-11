//
//  CustomAnyLayoutView.swift
//  Example
//
//  Created by MAHESHWARAN on 11/11/23.
//

import SwiftUI

struct CustomAnyLayoutView: View {
  /*
   iPhone Plus Models:
   
   1. horizontalSize:
   - Portrait: - Regular
   - Landscape: - Compact
   
   2. verticalSizeClass:
   - Portrait: - Compact
   - Landscape: - Regular
   */
  
  @Environment(\.horizontalSizeClass) var horizontalSizeClass
  @Environment(\.verticalSizeClass) var verticalSizeClass
  
  var body: some View {
    TabView {
      anyLayoutView
      horizontalSizeClassView
    }
    .tabViewStyle(.page)
    .indexViewStyle(.page(backgroundDisplayMode: .always))
  }
  
  // MARK: - HorizontalSize
  
  private var horizontalSizeClassView: some View {
    VStack(spacing: 10) {
      Text("Horizontal: \(horizontalSizeClass.debugDescription)")
      Text("Veritical: \(verticalSizeClass.debugDescription)")
      
      if horizontalSizeClass == .compact {
        VStack {
          Text("One")
          Text("Two")
          Text("Three")
        }
      } else {
        HStack {
          Text("One")
          Text("Two")
          Text("Three")
        }
      }
    }
  }
  
  
  // MARK: - AnyLayout
  
  private var layout: AnyLayout {
    horizontalSizeClass == .compact ? .init(VStackLayout()) : .init(HStackLayout())
  }
  
  private var anyLayoutView: some View {
    layout {
      Text("One")
      Text("Two")
      Text("Three")
    }
  }
}

#Preview {
  CustomAnyLayoutView()
}
