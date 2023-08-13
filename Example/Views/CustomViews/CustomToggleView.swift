//
//  CustomToggleView.swift
//  Examples
//
//  Created by MAHESHWARAN on 12/08/23.
//

import SwiftUI

struct CustomToggleView: View {
  
  @State private var isEnabled = false
  
  var body: some View {
    Toggle("choose Selection", isOn: $isEnabled)
      .padding(10)
  }
}

struct CustomToggleView_Previews: PreviewProvider {
  static var previews: some View {
    CustomToggleView()
  }
}
