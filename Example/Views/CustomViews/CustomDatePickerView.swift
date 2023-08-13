//
//  CustomDatePickerView.swift
//  Examples
//
//  Created by MAHESHWARAN on 06/08/23.
//

import SwiftUI

struct CustomDatePickerView: View {
  
  @State private var wakeUp = Date.now
  
  var body: some View {
    
    TabView {
      dateStyleOne
      datePickerWheel
      hourPicker
    }
    .tabViewStyle(.page)
    .indexViewStyle(.page(backgroundDisplayMode: .always))
  }
  
  private var dateStyleOne: some View {
    DatePicker("Please enter a date", selection: $wakeUp, in: Date.now...)
      .labelsHidden()
      .padding()
  }
  
  private var datePickerWheel: some View {
    DatePicker("Please enter a date", selection: $wakeUp)
      .padding()
      .datePickerStyle(.wheel)
      .labelsHidden()
  }
  
  private var hourPicker: some View {
    DatePicker("Please enter a date", selection: $wakeUp, displayedComponents: .hourAndMinute)
      .labelsHidden()
  }
}

struct CustomDatePickerView_Previews: PreviewProvider {
  static var previews: some View {
    CustomDatePickerView()
  }
}
