//
//  CustomNavigationTransitionView.swift
//  Example
//
//  Created by MAHESHWARAN on 03/11/23.
//

import SwiftUI

struct CustomNavigationTransitionView: View {
  
  @State private var isEnabled = true
  
  var body: some View {
    ZStack {
      Text("First View")
        .onTapGesture {
          withAnimation {
            isEnabled.toggle()
          }
        }
      
      if isEnabled {
        SecondView(isEnabled: $isEnabled)
          .transition(.move(edge: .trailing))
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
  
  struct SecondView: View {
    
    @Binding var isEnabled: Bool
    
    var body: some View {
      ZStack {
        Color.pink
        
        Text("Second View")
          .padding()
          .background(Color.blue.opacity(0.3))
          .clipShape(Capsule())
          .onTapGesture {
            withAnimation {
              isEnabled.toggle()
            }
          }
      }
    }
  }
}

#Preview {
  CustomNavigationTransitionView()
}
