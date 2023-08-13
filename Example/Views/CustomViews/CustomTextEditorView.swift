//
//  CustomTextEditorView.swift
//  Example
//
//  Created by MAHESHWARAN on 13/08/23.
//

import SwiftUI

struct CustomTextEditorView: View {
  
  @AppStorage("notes") private var notes = ""
  
  var body: some View {
    TextEditor(text: $notes)
      .navigationTitle("Notes")
      .navigationBarTitleDisplayMode(.inline)
      .padding()
      .tint(.pink)
  }
}

struct CustomTextEditorView_Previews: PreviewProvider {
  static var previews: some View {
    CustomTextEditorView()
  }
}
