//
//  CustomMoveItemView.swift
//  Examples
//
//  Created by MAHESHWARAN on 06/08/23.
//

import SwiftUI

struct CustomMoveItemView: View {
  
  @State private var users = ["Michelle", "Taylor", "Brandon", "Mike"]
  
  var body: some View {
    List {
      ForEach(users, id: \.self) { user in
        Text(user)
      }
      .onMove(perform: move)
    }
    .toolbar {
      EditButton()
    }
  }
  
  func move(from source: IndexSet, to destination: Int) {
    users.move(fromOffsets: source, toOffset: destination)
  }
}

struct CustomMoveItemView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      CustomMoveItemView()
    }
  }
}
