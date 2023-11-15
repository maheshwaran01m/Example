//
//  CustomRotationEffectView.swift
//  Example
//
//  Created by MAHESHWARAN on 15/11/23.
//

import SwiftUI

struct CustomRotationEffectView: View {
  
  @State private var rotation = CGFloat.zero
  
  var body: some View {
    ZStack {
      cardView
      rotationCardView
    }
  }
  
  private var cardView: some View {
    RoundedRectangle(cornerRadius: 16)
      .foregroundStyle(Color.blue.opacity(0.5))
      .frame(width: 250, height: 350)
  }
  
  private var rotationCardView: some View {
    RoundedRectangle(cornerRadius: 16, style: .continuous)
      .foregroundStyle(
        LinearGradient(colors: [.pink, .white, .orange], startPoint: .top, endPoint: .bottom)
      )
      .frame(width: 150, height: 650)
      .rotationEffect(.degrees(rotation))
      .mask(maskView)
      .onAppear(perform: rotationAnimation)
  }
  
  private func maskView() -> some View {
    RoundedRectangle(cornerRadius: 16, style: .continuous)
      .stroke(lineWidth: 7)
      .frame(width: 250, height: 350)
  }
  
  private func rotationAnimation() {
    withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
      rotation = 360
    }
  }
}

#Preview {
  CustomRotationEffectView()
}
