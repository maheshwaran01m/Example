//
//  CustomAnimationView.swift
//  Examples
//
//  Created by MAHESHWARAN on 12/08/23.
//

import SwiftUI

struct CustomAnimationView: View {
  var body: some View {
    TabView {
      flipView
      easeInRepeatView
      dampingView
      dragGestureView
    }
    .tabViewStyle(.page)
    .indexViewStyle(.page(backgroundDisplayMode: .always))
  }
  
  // Flip
  
  @State private var animationAmount = 0.0
  
  private var flipView: some View {
    Button("Tap Me") {
      withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
          animationAmount += 360
      }
    }
    .padding(50)
    .background(.red)
    .foregroundColor(.white)
    .clipShape(Circle())
    .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
  }
  
  // EaseIn Repeat
  
  @State private var easeInAnimationAmount = 1.0
  
  private var easeInRepeatView: some View {
    Button("Tap Me") {
      easeInAnimationAmount += 1
    }
    .padding(50)
    .background(.red)
    .foregroundColor(.white)
    .clipShape(Circle())
    
    .scaleEffect(easeInAnimationAmount)
    .animation(
      .easeInOut(duration: 1)
      .repeatCount(3, autoreverses: true),
      value: easeInAnimationAmount
    )
  }
  
  // Damping
  
  @State private var enabled = false
  
  private var dampingView: some View {
    Button("Tap Me") {
      enabled.toggle()
    }
    .frame(width: 200, height: 200)
    .background(enabled ? .blue : .red)
    .animation(nil, value: enabled)
    .foregroundColor(.white)
    .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
    .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enabled)
  }
  
  // drag Gesture
  
  let letters = Array("Hello SwiftUI")
  @State private var dragAmount = CGSize.zero
  
  private var dragGestureView: some View {
    HStack(spacing: 0) {
      ForEach(0..<letters.count, id: \.self) { num in
        Text(String(letters[num]))
          .padding(5)
          .font(.title)
          .background(enabled ? .blue : .red)
          .offset(dragAmount)
          .animation(.default.delay(Double(num) / 20), value: dragAmount)
      }
    }
    .gesture(
      DragGesture()
        .onChanged { dragAmount = $0.translation }
        .onEnded { _ in
          dragAmount = .zero
          enabled.toggle()
        }
    )
  }
}

struct CustomAnimationView_Previews: PreviewProvider {
  static var previews: some View {
    CustomAnimationView()
  }
}
