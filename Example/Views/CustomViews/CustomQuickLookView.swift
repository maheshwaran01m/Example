//
//  CustomQuickLookView.swift
//  Example
//
//  Created by MAHESHWARAN on 29/08/23.
//

import SwiftUI
import QuickLook

struct CustomQuickLookView: View {
  
  @State private var url: URL? = nil
  
  var directory: URL {
    let directory = URL.documentsDirectory
    return directory.appending(path: "Example").appendingPathExtension("png")
  }
  
  var body: some View {
    Button("View File") {
      url = directory
    }
    .quickLookPreview($url)
  }
  
}

struct CustomQuickLookView_Previews: PreviewProvider {
  static var previews: some View {
    CustomQuickLookView()
  }
}
