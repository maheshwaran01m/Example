//
//  CustomSafeAreaView.swift
//  Examples
//
//  Created by MAHESHWARAN on 12/08/23.
//

import SwiftUI

struct CustomSafeAreaView: View {
  
  var body: some View {
    ZStack {
      Color.gray.opacity(0.3)
      Text("Hello, World!")
    }
    .navigationBarTitleDisplayMode(.inline)
    .safeAreaInset(edge: .top, alignment: .center, content: titleView)
    .safeAreaInset(edge: .leading, content: titleView)
    .safeAreaInset(edge: .trailing, content: titleView)
    .safeAreaInset(edge: .bottom, alignment: .trailing, spacing: 0, content: titleView)
  }
  
  private func titleView() -> some View {
    Text("Example")
      .foregroundColor(.blue)
      .padding(5)
      .background(Color.gray.opacity(0.2),
                  in: RoundedRectangle(cornerRadius: 8))
  }
}

struct CustomSafeAreaView_Previews: PreviewProvider {
  static var previews: some View {
    CustomSafeAreaView()
  }
}
