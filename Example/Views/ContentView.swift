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
      mainView
        .navigationTitle("SwiftUI")
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
    }
  }
  
  @ViewBuilder
  private var mainView: some View {
    if !filterViews.isEmpty {
      listView
    } else {
      placeholderView
    }
  }
  
  private var listView: some View {
    List(filterViews, id: \.rawValue) { item in
      listRowView(for: item)
    }
    .listStyle(.plain)
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
  
  // MARK: - Placeholder View
  
  private var placeholderView: some View {
    ZStack {
      Color.secondary.opacity(0.1)
      VStack(spacing: 16) {
        iconView
        titleView
      }
    }
    .ignoresSafeArea(.container, edges: .bottom)
  }
  
  private var titleView: some View {
    Text("No Examples Available")
      .font(.title3)
      .frame(minHeight: 22)
      .multilineTextAlignment(.center)
      .foregroundStyle(.secondary)
  }
  
  private var iconView: some View {
    Image(systemName: "square.on.square.badge.person.crop")
      .font(.title)
      .foregroundStyle(Color.secondary)
      .frame(minWidth: 20, minHeight: 20)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
