//
//  CustomTextFieldView.swift
//  Example
//
//  Created by MAHESHWARAN on 13/08/23.
//

import SwiftUI

struct CustomTextFieldView: View {
  
  var body: some View {
    TabView {
      textFieldFocuseView
      decimalView
    }
    .tabViewStyle(.page)
    .indexViewStyle(.page(backgroundDisplayMode: .always))
  }
  
  // MARK: - Focus
  
  enum FieldFocus {
    case first, second
  }
  
  @State private var textValue = ""
  @State private var textValueOne = ""
  @FocusState private var fieldFocus: FieldFocus?
  
  var textFieldFocuseView: some View {
    VStack(alignment: .leading) {
      Text(textValue)
      
      TextField("Enter Value", text: $textValue)
        .textFieldStyle(.roundedBorder)
        .keyboardType(.default)
        .focused($fieldFocus, equals: .first)
        .submitLabel(.next)
      
      Text(textValueOne)
      TextField("Enter your first name", text: $textValueOne)
        .focused($fieldFocus, equals: .second)
        .textContentType(.givenName)
        .submitLabel(.next)
        .focused($fieldFocus, equals: .second)
    }
    .onSubmit {
      switch fieldFocus {
      case .first:
        fieldFocus = .second
      default:
        fieldFocus = .none
      }
    }
    .padding(.horizontal, 10)
  }
  
  // MARK: - decimalView
  
  @State private var textValueTwo = ""
  @FocusState private var nameIsFocused: Bool
  
  private var decimalView: some View {
    
    TextField("Enter Decimal value", text: $textValueTwo)
      .textFieldStyle(.roundedBorder)
      .keyboardType(.decimalPad)
      .onChange(of: textValueTwo, perform: handleTextFieldValue)
      .focused($nameIsFocused)
      .toolbar(content: doneButton)
  }
  
  private func handleTextFieldValue(_ newValue: String) {
    // Restrict mulitple dots
    let filtered = textValueTwo.filter { $0 == "." }
    if filtered.count > 1, let index = textValueTwo.firstIndex(of: ".") {
      textValueTwo.removeAll(where: { $0 == "." })
      textValueTwo.insert(".", at: index)
    } else {
      textValueTwo = newValue
    }
  }
  
  @ToolbarContentBuilder
  private func doneButton() -> some ToolbarContent {
    ToolbarItemGroup(placement: .keyboard) {
      if nameIsFocused {
        Spacer()
        Button("Done") {
          nameIsFocused = false
        }
      }
    }
  }
}

struct CustomTextFieldView_Previews: PreviewProvider {
  static var previews: some View {
    CustomTextFieldView()
  }
}
