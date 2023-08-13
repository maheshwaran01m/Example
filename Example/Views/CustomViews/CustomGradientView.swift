//
//  CustomGradientView.swift
//  Examples
//
//  Created by MAHESHWARAN on 06/08/23.
//

import SwiftUI

struct CustomGradientView: View {
  
  var body: some View {
    TabView {
      linearGradinent
      circularView
      radialGradient
      angularGradient
    }
    .tabViewStyle(.page)
    .indexViewStyle(.page(backgroundDisplayMode: .always))
  }
  
  private var linearGradinent: some View {
    LinearGradient(gradient: Gradient(colors: [.white, .blue]), startPoint: .leading, endPoint: .bottomTrailing)
  }
  
  private var circularView: some View {
    Circle()
      .strokeBorder(.bar, lineWidth: 6)
      .background(Circle().fill(.pink.opacity(0.8)))
      .padding()
      .shadow(color: .blue, radius: 6, x: 0, y: 3)
  }
  
  private var radialGradient: some View {
    RadialGradient(gradient: Gradient(colors: [.blue, .pink]), center: .center, startRadius: 20, endRadius: 200)
  }
  
  private var angularGradient: some View {
    AngularGradient(gradient: Gradient(
      colors: [.red, .yellow, .green,
               .blue, .purple, .red]), center: .center)
  }
}

struct CustomGradientView_Previews: PreviewProvider {
  static var previews: some View {
    CustomGradientView()
  }
}
