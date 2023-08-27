//
//  CustomPopOverView.swift
//  Example
//
//  Created by MAHESHWARAN on 26/08/23.
//

import SwiftUI

struct CustomPopOverView: View {
  
  var body: some View {
    customView
  }
  
  @State private var showingPopover = false
  
  var customView: some View {
    Button("Show Menu") {
      showingPopover.toggle()
    }
    .popover(isPresented: $showingPopover) {
      examplePopOverView
    }
  }
  
  @State private var height: CGFloat = .zero
  
  var examplePopOverView: some View {
    VStack {
      ForEach(0..<2) { _ in
        Text("Your content here")
          .font(.headline)
          .padding()
      }
    }
    .getHeight($height)
    .presentationDetents([.height(height)])
    .frame(maxWidth: .infinity)
  }
}

struct CustomPopOverView_Previews: PreviewProvider {
  static var previews: some View {
    CustomPopOverView()
      .previewDevice("iPad Pro (11-inch) (4th generation)")
  }
}
