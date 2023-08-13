//
//  ViewCoordinator.swift
//  Example
//
//  Created by MAHESHWARAN on 13/08/23.
//

import SwiftUI

extension ContentView {
  
  enum ViewCoordinator: String, CaseIterable {
    case text, textFieldView, textEditorView
    
    
    var title: String {
      switch self {
      case .text: return "Text"
      case .textFieldView: return "Text Field"
      case .textEditorView: return "Text Editor"
      }
    }
    
    
    @ViewBuilder
    var destinationView: some View {
      switch self {
      case .text: CustomTextView()
      case .textFieldView: CustomTextFieldView()
      case .textEditorView: CustomTextEditorView()
      }
    }
  }
}
