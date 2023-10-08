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
    titleView("Navigation View")
      .navigationDestination(isPresented: $isPresented) {
        titleView("Second View")
      }
      .navigationTitle("Home")
      .navigationBarTitleDisplayMode(.large)
  }
  
  private func titleView(_ title: String) -> some View {
    Text(title)
      .padding()
      .background(.blue.opacity(0.3))
      .clipShape(Capsule())
      .onTapGesture {
        isPresented.toggle()
      }
      .navigationTitle(title)
      .navigationBarTitleDisplayMode(.inline)
  }
}

private struct CustomNavigationViewExample: View {
  
  var body: some View {
    navigationExample
  }
  
  private func titleView(_ title: String) -> some View {
    Text(title)
      .padding()
      .background(.blue.opacity(0.3))
      .clipShape(Capsule())
  }
  
  // MARK: - NavigationPath
  
  @State private var path = [String]()
  
  var navigationExample: some View {
    NavigationStack(path: $path) {
      
      Button {
        path.append(contentsOf: ["one", "two", "three"])
      } label: {
        titleView("Navigation Path")
      }
      .navigationDestination(for: String.self) {
        secondViewExample(for: $0)
          .navigationTitle($0.capitalized)
      }
    }
  }
  
  private func secondViewExample(for title: String) -> some View {
    VStack {
      Button {
        path.append(contentsOf: ["four", "five", "six"])
      } label: {
        titleView("Second View")
      }
      
      Button {
        path.removeLast(path.count)
      } label: {
        titleView("Pop To Root")
      }
    }
  }
}

#Preview {
  NavigationStack {
    CustomNavigationViewExample()
  }
}
