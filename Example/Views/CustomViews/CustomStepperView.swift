//
//  CustomStepperView.swift
//  Examples
//
//  Created by MAHESHWARAN on 06/08/23.
//

import SwiftUI

struct CustomStepperView: View {
  
  @State private var sleepAmount = 8.0
  
  var body: some View {
    TabView {
      stepperView
      stepperViewOne
    }
    .tabViewStyle(.page)
    .indexViewStyle(.page(backgroundDisplayMode: .always))
  }
  
  private var stepperView: some View {
    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
      .padding()
  }
  
  private var stepperViewOne: some View {
    Stepper("\(sleepAmount) hours", value: $sleepAmount, in: 4...12)
      .padding()
  }
}

struct CustomStepperView_Previews: PreviewProvider {
  static var previews: some View {
    CustomStepperView()
  }
}
