//
//  CustomDragGestureView.swift
//  Example
//
//  Created by MAHESHWARAN on 02/10/23.
//

import SwiftUI

struct CustomDragGestureView: View {
  
  @State private var currentDragOffsetY = CGFloat.zero
  @State private var endingOffsetY = CGFloat.zero
  @State private var startingOffsetY = UIScreen.main.bounds.height * 0.80
  
  var body: some View {
    signUpView
      .offset(y: startingOffsetY)
      .offset(y: currentDragOffsetY)
      .offset(y: endingOffsetY)
      .gesture(dragGestureView)
  }
  
  var dragGestureView: some Gesture {
    DragGesture()
      .onChanged { value in
        withAnimation(.spring){
          currentDragOffsetY = value.translation.height
        }
      }
      .onEnded { value in
        withAnimation(.spring){
          if currentDragOffsetY < -150 {
            endingOffsetY = -startingOffsetY
          } else if endingOffsetY != 0 && currentDragOffsetY > 150 {
            endingOffsetY = 0
          }
          currentDragOffsetY = 0
        }
      }
  }
  
  private var signUpView: some View {
    VStack {
      Image(systemName: "chevron.up")
        .padding(.top)
      Button("Sign Up") {
        // login code
      }
      .padding()
      .buttonStyle(.borderedProminent)
      
      Spacer()
    }
    .frame(maxWidth: .infinity)
    .background(Color.pink.opacity(0.3))
    .clipShape(RoundedRectangle(cornerRadius: 25.0))
    .ignoresSafeArea(.container, edges: .bottom)
  }
}

#Preview {
  CustomDragGestureView()
}
