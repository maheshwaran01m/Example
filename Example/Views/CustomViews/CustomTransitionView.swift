//
//  CustomTransitionView.swift
//  Example
//
//  Created by MAHESHWARAN on 01/10/23.
//

import SwiftUI

struct CustomTransitionView: View {
  
  @State private var isPresented = false
  
  var body: some View {
    TabView {
      mainView(.slide)
      mainView(.scale, name: "Scale")
      mainView(.opacity, name: "Opacity")
      mainView(.move(edge: .leading), name: "Move leading")
      mainView(.move(edge: .trailing), name: "Move trailing")
      mainView(.asymmetric(insertion: .move(edge: .leading),
                           removal: .move(edge: .trailing)), name: "Custom")
    }
    .tabViewStyle(.page(indexDisplayMode: .never))
  }
  
  
  private func mainView(_ transition: AnyTransition, name: String = "Slide") -> some View {
    ZStack(alignment: .bottom) {
      VStack(spacing: 20) {
        buttonView(for: name)
        
        Spacer()
        if isPresented {
          transitionView(for: transition)
        }
      }
    }
    .ignoresSafeArea(.container, edges: .bottom)
  }
  
  private func buttonView(for title: String) -> some View {
    Button {
      withAnimation {
        isPresented.toggle()
      }
    } label: {
      Text(title)
      .padding()
      .background(.blue.opacity(0.3))
      .clipShape(Capsule())
    }
  }
  
  func transitionView(for transition: AnyTransition = .move(edge: .bottom)) -> some View {
    RoundedRectangle(cornerRadius: 30)
      .fill(Color.pink.opacity(0.3))
      .frame(height: 400)
      .frame(maxWidth: .infinity)
      .transition(transition.animation(.spring))
  }
}

#Preview {
  CustomTransitionView()
}
