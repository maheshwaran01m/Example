//
//  CustomDialogAlertView.swift
//  Examples
//
//  Created by MAHESHWARAN on 12/08/23.
//

import SwiftUI

struct CustomDialogAlertView: View {
  
  @State private var showingConfirmation = false
  @State private var backgroundColor = Color.white
  
  var body: some View {
    Text("Choose Background color")
      .foregroundStyle(.linearGradient(colors: [.red, .yellow], startPoint: .leading, endPoint: .trailing))
      .frame(width: 300, height: 300)
      .background(backgroundColor)
      .onTapGesture {
        showingConfirmation = true
      }
    
      .confirmationDialog("Change background", isPresented: $showingConfirmation) {
        Button("Gray") { backgroundColor = .gray }
        Button("Green") { backgroundColor = .green.opacity(0.3) }
        Button("Blue") { backgroundColor = .blue.opacity(0.2) }
        Button("Cancel", role: .cancel) { }
      } message: {
        Text("Select a new color")
      }
  }
}

struct CustomDialogAlertView_Previews: PreviewProvider {
  static var previews: some View {
    CustomDialogAlertView()
  }
}
