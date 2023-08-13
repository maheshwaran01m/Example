//
//  CustomSwipeActionView.swift
//  Examples
//
//  Created by MAHESHWARAN on 12/08/23.
//

import SwiftUI

struct CustomSwipeActionView: View {
  
  var body: some View {
    List {
      Text("Hello")
        .swipeActions(edge: .leading) {
          Button("Pin") {
            print("Awesome!")
          }
          .tint(.green)
        }
      
      Text("Welcome to swiftUI")
        .swipeActions {
          Button("Delete") {
            print("Deleted!")
          }
          .tint(.red)
        }
    }
  }
}

struct CustomSwipeActionView_Previews: PreviewProvider {
  static var previews: some View {
    CustomSwipeActionView()
  }
}
