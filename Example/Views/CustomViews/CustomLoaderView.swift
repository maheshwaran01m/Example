//
//  CustomLoaderView.swift
//  Examples
//
//  Created by MAHESHWARAN on 12/08/23.
//

import SwiftUI

struct CustomLoaderView: View {
  
  @State private var rotation = 0.0
  
  var body: some View {
    TabView {
      loaderView
    }
    .tabViewStyle(.page)
  }
  
  private var loaderView: some View {
    GeometryReader { proxy in
      ZStack {
        backgroundView
        mainCiruclarView
        labelView(proxy)
      }
    }
  }
  
  private var backgroundView: some View {
    Circle()
      .stroke(Color.gray.opacity(0.2), lineWidth: 4)
  }
  
  private var mainCiruclarView: some View {
    Circle()
      .trim(from: 0, to: 0.25)
      .stroke(Color.blue, style: .init(lineWidth: 4, lineCap: .round))
      .frame(alignment: .center)
      .rotationEffect(.degrees(rotation))
      .onAppear {
        withAnimation(
          .linear(duration: 1)
          .speed(0.5)
          .repeatForever(autoreverses: false)) {
            rotation = 360.0
          }
      }
  }
  
  private func labelView(_ proxy: GeometryProxy) -> some View {
    Text("Loading..")
      .padding(proxy.size.width * 0.2)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

struct CustomLoaderView_Previews: PreviewProvider {
  static var previews: some View {
    CustomLoaderView()
      .frame(width: 150, height: 150)
  }
}
