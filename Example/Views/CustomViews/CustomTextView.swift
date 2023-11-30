//
//  CustomTextView.swift
//  Example
//
//  Created by MAHESHWARAN on 13/08/23.
//

import SwiftUI

struct CustomTextView: View {
  
  var body: some View {
    TabView {
      VStack {
        titleView
        titleViewOne
      }
      VStack(spacing: 40) {
        rectangleView
        roundedRectangleView
      }
      titleView2
      roundRectangleViewTwo
      exampleForFixedSize
    }
    .tabViewStyle(.page)
  }
  
  private var titleView: some View {
    Text("Hello, World!")
      .font(.title)
  }
  
  private var titleView2: some View {
    "Hello, World!"
      .font(.title)
  }
  
  private var titleViewOne: some View {
    Text("Hello, World!")
      .font(.title)
      .bold()
      .padding(10)
      .foregroundColor(Color.primary)
      .background(Color.gray.opacity(0.2), in: Capsule())
  }
  
  private var rectangleView: some View {
    Text("Hello World")
      .frame(width: 275, height: 275)
      .overlay(
        Rectangle()
          .stroke(.primary, style: .init(
            lineWidth: 3,
            lineCap: .round,
            lineJoin: .round,
            dash: [60, 215],
            dashPhase: 25))
      )
  }
  
  private var roundedRectangleView: some View {
    Text("Hello World")
      .frame(width: 320, height: 320)
      .overlay(
        RoundedRectangle(cornerRadius: 16, style: .circular)
          .stroke(.primary, style: .init(
            lineWidth: 3,
            lineCap: .round,
            lineJoin: .round,
            dash: [65, 255],
            dashPhase: 210) // -110
          )
      ) // 320*4 = 1280 -> [65*4 + 255*4]
  }
  
  private var roundRectangleViewTwo: some View {
    ZStack {
      ForEach(0...3, id: \.self) { index in
        RoundedRectangle(cornerRadius: 16, style: .circular)
          .trim(from: 0.58, to: 0.66)
          .stroke(Color.primary,
                  style: .init(lineWidth: 2, lineCap: .round, lineJoin: .round))
          .rotationEffect(.init(degrees: Double(index) * 90))
      }
    }
    .frame(width: 320, height: 320)
  }
  
  private var exampleForFixedSize: some View {
    Text("Rest Password using your email address or phone number.")
      .foregroundColor(.white)
      .padding()
      .frame(maxWidth: .infinity)
      .background(.gray.opacity(0.8))
      .multilineTextAlignment(.leading)
      .clipShape(Capsule())
    
      .fixedSize(horizontal: false, vertical: true)
      .padding(.horizontal, 10)
  }
}

struct CustomTextView_Previews: PreviewProvider {
  static var previews: some View {
    CustomTextView()
  }
}
