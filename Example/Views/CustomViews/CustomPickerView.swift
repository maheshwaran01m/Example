//
//  CustomPickerView.swift
//  Example
//
//  Created by MAHESHWARAN on 13/08/23.
//

import SwiftUI

struct CustomPickerView: View {
  
  @State private var numberOfPeople = 2
  
  var body: some View {
    TabView {
      pickerViewInline
      pickerViewSegmented
      pickerViewWheel
      pickerViewInForm
    }
    .tabViewStyle(.page)
    .indexViewStyle(.page(backgroundDisplayMode: .always))
  }
  
  private var pickerViewInline: some View {
    Picker("Number of people", selection: $numberOfPeople) {
      ForEach(0..<100) {
        Text("\($0) people")
      }
    }
    .pickerStyle(.menu)
  }
  
  private var pickerViewSegmented: some View {
    Picker("Number of people", selection: $numberOfPeople) {
      ForEach(0..<3) {
        Text("\($0) people")
      }
    }
    .pickerStyle(.segmented)
  }
  
  private var pickerViewWheel: some View {
    Picker("Number of people", selection: $numberOfPeople) {
      ForEach(0..<3) {
        Text("\($0) people")
      }
    }
    .pickerStyle(.wheel)
  }
  
  private var pickerViewInForm: some View {
    Form {
      Picker("Number of people", selection: $numberOfPeople) {
        ForEach(2 ..< 100) {
          Text("\($0) people")
        }
      }
      .pickerStyle(.navigationLink)
    }
  }
}

struct CustomPickerView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      CustomPickerView()
    }
  }
}
