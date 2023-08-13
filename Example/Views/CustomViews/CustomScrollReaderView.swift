//
//  CustomScrollReaderView.swift
//  Examples
//
//  Created by MAHESHWARAN on 07/08/23.
//

import SwiftUI

struct CustomScrollReaderView: View {
  
  var body: some View {
    ScrollViewReader { proxy in
      List(0..<100, id: \.self) { i in
        Text("Example \(i)")
          .id(i)
      }
      .safeAreaInset(edge: .bottom) {
        Button("Jump to #50") {
          proxy.scrollTo(50)
        }
        .buttonStyle(.borderedProminent)
        .padding(.horizontal, 10)
      }
    }
  }
}

struct CustomScrollReaderView_Previews: PreviewProvider {
  static var previews: some View {
    CustomScrollReaderView()
  }
}
