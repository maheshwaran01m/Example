//
//  CustomSegmentedControlView.swift
//  Examples
//
//  Created by MAHESHWARAN on 12/08/23.
//

import SwiftUI

struct CustomSegmentedControlView: View {
  
  @State private var tipPercentage = 20
  let tipPercentages = [10, 15, 20, 25, 0]
  
  var body: some View {
    Picker("Tip percentage", selection: $tipPercentage) {
      ForEach(tipPercentages, id: \.self) {
        Text($0, format: .percent)
      }
    }
    .pickerStyle(.segmented)
    .padding(10)
  }
}

struct CustomSegmentedControlView_Previews: PreviewProvider {
  static var previews: some View {
    CustomSegmentedControlView()
  }
}
