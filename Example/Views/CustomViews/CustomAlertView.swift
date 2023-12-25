//
//  CustomAlertView.swift
//  Examples
//
//  Created by MAHESHWARAN on 12/08/23.
//

import SwiftUI

struct CustomAlertView: View {
  
  var body: some View {
    TabView {
      textFieldAlertView
      customAlertView
      customErrorView
    }
    .tabViewStyle(.page)
    .indexViewStyle(.page(backgroundDisplayMode: .always))
  }
  
  // MARK: - Alert
  @State private var showingAlert: String?
  
  var customAlertView: some View {
    Button("Show Alert") {
      showingAlert = "Example alert"
    }
    .alert("Important message", isPresented: .init($showingAlert)) {
      Button("Delete", role: .destructive) { }
      Button("Cancel", role: .cancel) { }
    }
  }
  
  // MARK: - TextField
  
  @State private var isPresented = false
  @State private var fileName = ""
  
  private var textFieldAlertView: some View {
    
    Button(fileName.isEmpty ? "Submit" : fileName) {
      isPresented.toggle()
    }
    .alert("Choose FileName", isPresented: $isPresented) {
      VStack {
        TextField("Enter FileName", text: $fileName)
        
        Button("Save") {}
        Button("Skip", role: .cancel) {
          print("Skip")
        }
        
        Button("Cancel", role: .destructive) {
          print("Cancel")
        }
      }
    }
  }
  
  private var customButtonView: some View {
    Button("four", role: .destructive, action: {})
      .buttonStyle(.plain)
      .foregroundColor(.red)
  }
  
  // MARK: - Custom Error
  
  @State private var error: Error?
  
  enum CustomError: Error, LocalizedError {
    case badURL
    case custom(String)
    
    var errorDescription: String? {
      switch self {
      case .badURL:
        return "No Internet"
      case .custom(let string):
        return string
      }
    }
  }
  
  private var customErrorView: some View {
    Button("Custom Error Alert") {
      error = CustomError.custom("Something went wrong")
    }
    .alert(error?.localizedDescription ?? "Important message", isPresented: .init($error)) {
      Button("Ok") { }
    }
  }
}

struct CustomAlertView_Previews: PreviewProvider {
  static var previews: some View {
    CustomAlertView()
  }
}
