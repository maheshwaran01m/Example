//
//  CustomSearchView.swift
//  Examples
//
//  Created by MAHESHWARAN on 12/08/23.
//

import SwiftUI

struct CustomSearchView: View {
  
  @StateObject private var viewModel = CustomSearchViewModel()
  
  var body: some View {
    NavigationStack {
      List(viewModel.filterRecords, id: \.self) { record in
        Text(record)
      }
      .searchable(text: $viewModel.searchText)
    }
  }
}

struct CustomSearchView_Previews: PreviewProvider {
  static var previews: some View {
    CustomSearchView()
  }
}

private class CustomSearchViewModel: Identifiable, ObservableObject {
  
  @Published var records: [String] = []
  @Published var searchText = ""
  
  init(_ records: [String] = []) {
    self.records = records
    setUpRecords()
  }
  
  func setUpRecords() {
    var records = [String]()
    for i in 0..<50 {
      records.append("record \(i)")
    }
    self.records = records
  }
  
  var filterRecords: [String] {
    guard !searchText.isEmpty else { return records }
    return records.filter { $0.lowercased().localizedCaseInsensitiveContains(searchText.lowercased()) }
  }
}
