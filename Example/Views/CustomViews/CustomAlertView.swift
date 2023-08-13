//
//  CustomAlertView.swift
//  Examples
//
//  Created by MAHESHWARAN on 12/08/23.
//

import SwiftUI

struct CustomAlertView: View {
  
  @State private var showingAlert = false
  
  var body: some View {
    Button("Show Alert") {
      showingAlert = true
    }
    .alert("Important message", isPresented: $showingAlert) {
      Button("Delete", role: .destructive) { }
      Button("Cancel", role: .cancel) { }
    }
  }
}

struct CustomAlertView_Previews: PreviewProvider {
  static var previews: some View {
    CustomAlertView()
  }
}
