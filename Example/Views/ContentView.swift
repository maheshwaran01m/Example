//
//  ContentView.swift
//  Example
//
//  Created by MAHESHWARAN on 13/08/23.
//

import SwiftUI

struct ContentView: View {
  
  @State private var viewCoordinator = ViewCoordinator.allCases
  @State private var searchText = ""
  
  private var filterViews: [ViewCoordinator] {
    guard !searchText.isEmpty else { return viewCoordinator }
    return viewCoordinator.filter { $0.title.lowercased().localizedCaseInsensitiveContains(searchText) }
  }
  
  var body: some View {
    NavigationStack {
      List(filterViews, id: \.rawValue) { item in
        listRowView(for: item)
      }
      .listStyle(.plain)
      .navigationTitle("SwiftUI")
      .searchable(text: $searchText)
    }
  }
  
  private func listRowView(for item: ViewCoordinator) -> some View {
    NavigationLink(item.title, destination: item.destinationView)
      .listRowSeparator(.hidden)
      .padding(.horizontal, 8)
      .listRowBackground(
        Color.secondary.opacity(0.1)
          .clipShape(RoundedRectangle(cornerRadius: 16))
          .padding([.vertical, .horizontal], 4)
      )
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
