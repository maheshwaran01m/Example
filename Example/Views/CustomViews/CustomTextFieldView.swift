//
//  CustomTextFieldView.swift
//  Example
//
//  Created by MAHESHWARAN on 13/08/23.
//

import SwiftUI
import Combine

struct CustomTextFieldView: View {
  
  var body: some View {
    TabView {
      alertTextFieldView
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
      .numericText($textValueTwo, isDecimal: true)
      .focused($nameIsFocused)
      .toolbar(content: doneButton)
      .onAppear {
        UITextField.appearance().clearButtonMode = .whileEditing
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
  
  // MARK: - Alert TextField
  
  @StateObject private var viewModel = AlertTextFieldViewModel()
  
  var alertTextFieldView: some View {
    VStack(spacing: 10) {
      Text(viewModel.customFileName ?? "")
      
      Button("Get FileName") {
        viewModel.showAlert = true
      }
    }
    .alert("Enter FileName", isPresented: $viewModel.showAlert, actions: alertTextFieldGetFileName)
  }
  
  @ViewBuilder
  private func alertTextFieldGetFileName() -> some View {
    TextField("Enter FileName", text: $viewModel.fileName)
      .onAppear(perform: viewModel.updateFileNameText)
    Button("Cancel", action: {})
    Button("Done", action: viewModel.updateFileName)
      .disabled(viewModel.fileName.isEmpty)
  }
}

extension CustomTextFieldView {
  
  class AlertTextFieldViewModel: ObservableObject {
    
    @Published var fileName = " "
    @Published var customFileName: String?
    @Published var showAlert = false
    @Published var isDoneEnabled = false
    
    func updateFileName() {
      if !fileName.isEmpty {
        customFileName = fileName
      }
    }
    
    func updateFileNameText() {
      /* Issue when implementing an alert with a TextField. Save button action to be disabled until
       user enter some fileName, but the action block will never executed when the button
       has initially disable, so i've used some hack to handle this case.
       Refer: https://developer.apple.com/forums/thread/737964
       */
      DispatchQueue.main.async { [weak self] in
        self?.fileName = ""
      }
    }
  }
}

struct CustomTextFieldView_Previews: PreviewProvider {
  static var previews: some View {
    CustomTextFieldView()
  }
}

struct NumericViewModifier: ViewModifier {
  
  @Binding var text: String
  var isDecimal = false
  
  func body(content: Content) -> some View {
    content
      .keyboardType(isDecimal ? .decimalPad : .numberPad)
      .onReceive(Just(text)) { value in
        var numeric = "0123456789"
        let separtor = Locale.current.decimalSeparator ?? "."
        
        if isDecimal { numeric += separtor }
        
        if value.components(separatedBy: separtor).count-1 > 1 {
          text = value.dropLast().description
        } else {
          let filtered = value.filter { numeric.contains($0) }
          
          guard filtered != value else { return }
          text = filtered
        }
      }
  }
}

extension View {
  
  func numericText(_ binding: Binding<String>, isDecimal: Bool = false) -> some View {
    self.modifier(NumericViewModifier(text: binding, isDecimal: isDecimal))
  }
}
