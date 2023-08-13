//
//  CustomToolBarButtonView.swift
//  Examples
//
//  Created by MAHESHWARAN on 12/08/23.
//

import SwiftUI

struct CustomToolBarButtonView: View {
  
  var body: some View {
    Text("Hello, World!")
      .toolbar {
        toolBarButton("Leading", placement: .navigationBarLeading)
        toolBarButton("Trailing", placement: .navigationBarTrailing)
        toolBarButton("bottomBar", placement: .bottomBar)
        toolBarButton("Title", placement: .principal)
      }
  }
  
  private func toolBarButton(
    _ title: String,
    placement: ToolbarItemPlacement = .automatic) -> some ToolbarContent {
      
      ToolbarItem(placement: placement) {
        Button(title) {
          print("clicked")
        }
        .buttonStyle(.borderedProminent)
        .clipShape(Capsule())
      }
    }
}

struct CustomToolBarButtonView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      CustomToolBarButtonView()
    }
  }
}
