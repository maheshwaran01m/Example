//
//  CustomProgressView.swift
//  Examples
//
//  Created by MAHESHWARAN on 13/08/23.
//

import SwiftUI

struct CustomProgressView: View {
  @State private var downloadAmount = 0.1
  
  var body: some View {
    VStack {
      ProgressView("Downloading…", value: downloadAmount, total: 100)
    }
    .padding()
    .onTapGesture {
      if downloadAmount < 100 {
        downloadAmount += 2.0
        
      } else {
        downloadAmount = 0.0
      }
    }
  }
}

struct CustomProgressView_Previews: PreviewProvider {
  static var previews: some View {
    CustomProgressView()
  }
}
