//
//  CustomListView.swift
//  Examples
//
//  Created by MAHESHWARAN on 06/08/23.
//

import SwiftUI

struct CustomListView: View {
  
  var body: some View {
    TabView {
      selectionListView
      hideRightChevronInlistView
      expandableListView
      listViewTint
    }
    .tabViewStyle(.page)
    .indexViewStyle(.page(backgroundDisplayMode: .always))
  }
  
  // MARK: - Selection
  
  @State private var selectionItem: Int?
  
  private var selectionListView: some View {
    List(0..<20, id: \.self, selection: $selectionItem) { item in
      titleView(item)
    }
    .listStyle(.plain)
  }
  
  private func titleView(_ item: Int) -> some View {
    Text(String(describing: item))
      .onTapGesture {
        selectionItem = item
      }
      .listRowSeparator(.hidden)
      .padding(.horizontal, 8)
    
      .listRowBackground(
        selectionColor(item)
          .clipShape(RoundedRectangle(cornerRadius: 16))
          .padding([.vertical, .horizontal], 4)
      )
  }
  
  private func selectionColor(_ item: Int) -> some View {
    return selectionItem == item ? Color.blue.opacity(0.3) : .secondary.opacity(0.1)
  }
  
  // MARK: - Hide Right Chevron
  
  private var hideRightChevronInlistView: some View {
    List(0..<10, id: \.self) { item in
      selectionView(item)
    }
    .navigationTitle("List")
  }
  
  private func selectionView(_ item: Int) -> some View {
    Text(String(describing: item))
    // Hide right chevron
      .overlay {
        NavigationLink(destination: destinationView, label: {})
          .opacity(0)
      }
  }
  
  private var destinationView: some View {
    Text("Second View")
  }
  
  // MARK: - ExpandListView
  
  private struct Expandable: Identifiable {
    let id: String = UUID().uuidString
    
    let title: String
    var children: [Expandable]?
  }
  
  private let example = (0..<5).map { Expandable(title: "Example \($0)", children: [.init(title: "apple"), .init(title: "twitter"), .init(title: "linkedIn")]) }
  
  private var expandableListView: some View {
    List(example, id: \.id, children: \.children) { item in
      Text(item.title)
    }
  }
  
  // MARK: - Tint
  
  var listViewTint: some View {
    List(1..<5) { i in
        Label("Row \(i)", systemImage: "\(i).circle")
            .listItemTint(i.isMultiple(of: 2) ? .red : .green)
    }
  }
}

struct CustomListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      CustomListView()
    }
  }
}
