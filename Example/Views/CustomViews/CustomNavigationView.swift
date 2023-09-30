//
//  CustomNavigationView.swift
//  Example
//
//  Created by MAHESHWARAN on 30/09/23.
//

import SwiftUI

struct CustomNavigationView: View {
  
  @State private var isPresented = false
  
  var body: some View {
    NavigationStack {
      titleView("Navigation View")
        .navigationDestination(isPresented: $isPresented) {
          titleView("Second View")
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.large)
    }
  }
  
  private func titleView(_ title: String) -> some View {
    Text(title)
      .padding()
      .background(.blue.opacity(0.3))
      .clipShape(Capsule())
      .onTapGesture {
        isPresented.toggle()
      }
  }
}

#Preview {
  NavigationStack {
    CustomNavigationView()
  }
}
