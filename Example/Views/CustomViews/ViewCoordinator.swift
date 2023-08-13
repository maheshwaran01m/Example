//
//  ViewCoordinator.swift
//  Example
//
//  Created by MAHESHWARAN on 13/08/23.
//

import SwiftUI

extension ContentView {
  
  enum ViewCoordinator: String, CaseIterable {
    case text, textFieldView, textEditorView, imageView, pickerView, stackView, colorView, gradientView,
         buttonView, stepperView, datePickerView, photoPickerView, moveItemView, listView, scrollReaderView,
         scrollView
    
    
    var title: String {
      switch self {
      case .text: return "Text"
      case .textFieldView: return "Text Field"
      case .textEditorView: return "Text Editor"
      case .imageView: return "Image"
      case .pickerView: return "Picker"
      case .stackView: return "Stack"
      case .colorView: return "Color"
      case .gradientView: return "Gradient"
      case .buttonView: return "Button"
      case .stepperView: return "Stepper"
      case .datePickerView: return "Date Picker"
      case .photoPickerView: return "Photo Picker"
      case .moveItemView: return "Move Item"
      case .listView: return "List"
      case .scrollReaderView: return "Scroll Reader"
      case .scrollView: return "Scroll"
      }
    }
    
    
    @ViewBuilder
    var destinationView: some View {
      switch self {
      case .text: CustomTextView()
      case .textFieldView: CustomTextFieldView()
      case .textEditorView: CustomTextEditorView()
      case .imageView: CustomImageView()
      case .pickerView: CustomPickerView()
      case .stackView: CustomStackView()
      case .colorView: CustomColorView()
      case .gradientView: CustomGradientView()
      case .buttonView: CustomButtonView()
      case .stepperView: CustomStepperView()
      case .datePickerView: CustomDatePickerView()
      case .photoPickerView: CustomPhotoPickerView()
      case .moveItemView: CustomMoveItemView()
      case .listView: CustomListView()
      case .scrollReaderView: CustomScrollReaderView()
      case .scrollView: CustomScrollView()
      }
    }
  }
}
