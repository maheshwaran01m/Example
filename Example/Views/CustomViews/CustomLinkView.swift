//
//  CustomLinkView.swift
//  Examples
//
//  Created by MAHESHWARAN on 12/08/23.
//

import SwiftUI

struct CustomLinkView: View {
  
  var body: some View {
    VStack(spacing: 10) {
      openURLUsingView
      customURLView
    }
  }
  
  // MARK: Open URL
  
  @Environment(\.openURL) var openURL
  
  var openURLUsingView: some View {
    Button("Visit Apple") {
      openURL(URL(string: "https://www.apple.com")!)
    }
    .buttonStyle(.bordered)
  }
  
  @ViewBuilder
  private var customURLView: some View {
    if let url = URL(string: "https://www.apple.com") {
      Link("Visit Apple", destination: url)
        .foregroundColor(.red)
        .buttonStyle(.bordered)
    }
  }
}

struct CustomLinkView_Previews: PreviewProvider {
  static var previews: some View {
    CustomLinkView()
  }
}
