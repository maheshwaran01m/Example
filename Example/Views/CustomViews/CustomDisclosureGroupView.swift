//
//  CustomDisclosureGroupView.swift
//  Example
//
//  Created by MAHESHWARAN on 13/08/23.
//

import SwiftUI

struct CustomDisclosureGroupView: View {
  @State private var revealDetails = false
  
  var body: some View {
    DisclosureGroup("Show Terms", isExpanded: $revealDetails) {
      Text("Long terms and conditions here long terms and conditions here long terms and conditions here long terms and conditions here long terms and conditions here long terms and conditions here.")
    }
    .frame(width: 300)
  }
}

struct CustomDisclosureGroupView_Previews: PreviewProvider {
  static var previews: some View {
    CustomDisclosureGroupView()
  }
}
