//
//  CustomFormView.swift
//  Examples
//
//  Created by MAHESHWARAN on 12/08/23.
//

import SwiftUI

struct CustomFormView: View {
  
  @State private var enableLogging = false
  @State private var selectedColor = "Red"
  @State private var colors = ["Red", "Green", "Blue"]
  
  var body: some View {
    Form {
      Section(footer: Text("Note: Enabling logging may slow down the app")) {
        Picker("Select a color", selection: $selectedColor) {
          ForEach(colors, id: \.self) {
            Text($0)
          }
        }
        .pickerStyle(.segmented)
        
        Toggle("Enable Logging", isOn: $enableLogging)
      }
      
      Section {
        Button("Save changes") {
          // action
        }
      }
    }
  }
}

struct CustomFormView_Previews: PreviewProvider {
  static var previews: some View {
    CustomFormView()
  }
}
