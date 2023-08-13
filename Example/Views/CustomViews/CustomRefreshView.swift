//
//  CustomRefreshView.swift
//  Examples
//
//  Created by MAHESHWARAN on 12/08/23.
//

import SwiftUI

struct CustomRefreshView: View {
  
  var body: some View {
    List(1..<10, id: \.self) { row in
      Text("Row \(row)")
    }
    .refreshable {
      print("Do your refresh work here")
    }
  }
}

struct CustomRefreshView_Previews: PreviewProvider {
  static var previews: some View {
    CustomRefreshView()
  }
}
