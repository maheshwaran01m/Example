//
//  ViewCoordinator.swift
//  Example
//
//  Created by MAHESHWARAN on 13/08/23.
//

import SwiftUI

extension ContentView {
  
  enum ViewCoordinator: String, CaseIterable {
    case text
    
    
    var title: String {
      switch self {
      case .text: return "Text"
      }
    }
    
    
    @ViewBuilder
    var destinationView: some View {
      switch self {
      case .text: CustomTextView()
      }
    }
  }
}
