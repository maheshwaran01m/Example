//
//  CustomGroupBoxView.swift
//  Example
//
//  Created by MAHESHWARAN on 13/08/23.
//

import SwiftUI

struct CustomGroupBoxView: View {
  
  var body: some View {
    groupBoxView
  }
  
  private var groupBoxView: some View {
    GroupBox {
      VStack (alignment: .leading){
        Text("Your account")
          .font(.headline)
        Text("Username: \(Text("iOS Dev").foregroundColor(.pink))")
        Text("Project: \(Text("SwiftUI").foregroundColor(.blue))")
      }
    }
  }
}

struct CustomGroupBoxView_Previews: PreviewProvider {
  static var previews: some View {
    CustomGroupBoxView()
  }
}
