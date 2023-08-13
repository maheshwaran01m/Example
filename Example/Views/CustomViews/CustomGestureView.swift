//
//  CustomGestureView.swift
//  Examples
//
//  Created by MAHESHWARAN on 12/08/23.
//

import SwiftUI

struct CustomGestureView: View {

  var body: some View {
    TabView {
      tapGestureView
      longPressGestureView
      highPriorityGesture
      simultaneousGesture
      dragGestureView
    }
    .tabViewStyle(.page)
    .indexViewStyle(.page(backgroundDisplayMode: .always))
  }
  
  // MARK: - Tap Gesture
  
  @State private var isEnabled = false
  
  var tapGestureView: some View {
    Text("Hello")
      .padding(20)
      .background(isEnabled ? Color.cyan : Color.gray.opacity(0.3), in: RoundedRectangle(cornerRadius: 16))
      .onTapGesture {
        isEnabled.toggle()
      }
  }
  
  // MARK: - Long Press Gesture
  
  private var longPressGestureView: some View {
    Text("Long Press Gesture")
    // Gesture
      .onLongPressGesture(minimumDuration: 1) {
        print("Long Press Gesture")
      } onPressingChanged: { inProgress in
        print("In progress: \(inProgress)!")
      }
  }
  
  // MARK: - Higher PriorityGesture -> First Consider
  
  private var highPriorityGesture: some View {
    VStack {
      Text("high Priority Gesture")
        .onTapGesture {
          print("Text tapped")
        }
    }
    .padding(25)
    .border(.yellow)
    .highPriorityGesture(
      TapGesture()
        .onEnded { _ in
          print("VStack tapped")
        }
    )
  }
  
  // MARK: - SimultaneousGesture
  
  private var simultaneousGesture: some View {
    VStack {
      Text("SimultaneousGesture")
        .onTapGesture {
          print("Text tapped")
        }
    }
    .padding(25)
    .border(.blue)
    .simultaneousGesture(
      TapGesture()
        .onEnded { _ in
          print("VStack tapped")
        }
    )
  }
  
  // MARK: - Drag Gesture
  
  @State private var dragAmount = CGSize.zero
  
  var dragGestureView: some View {
    LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
      .frame(width: 300, height: 200)
      .clipShape(RoundedRectangle(cornerRadius: 10))
    
      .offset(dragAmount)
      .animation(.spring(), value: dragAmount)
      .gesture(
        DragGesture()
          .onChanged { dragAmount = $0.translation }
          .onEnded { _ in
            withAnimation(.spring()) {
              dragAmount = .zero
            }
          }
      )
  }
}

struct CustomDragGestureView_Previews: PreviewProvider {
  static var previews: some View {
    CustomGestureView()
  }
}
