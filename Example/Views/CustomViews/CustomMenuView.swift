//
//  CustomMenuView.swift
//  Example
//
//  Created by MAHESHWARAN on 31/08/23.
//

import SwiftUI

struct CustomMenuView: View {
  var body: some View {
    Menu("Submit") {
      ForEach(0..<15, id: \.self) { i in
        Button {
          
        } label: {
          Label(i%2==0 ? "Save" : "Update",
                systemImage: i%2==0 ? "camera" : "trash")
        }
      }
    }
    .buttonStyle(.borderedProminent)
  }
}

struct CustomMenuView_Previews: PreviewProvider {
  static var previews: some View {
    CustomMenuView()
  }
}
