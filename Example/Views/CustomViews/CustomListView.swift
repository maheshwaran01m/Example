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
      customListBackgroundView
      customListRowBackgroundView
      customHeightListView
      customHeaderListView
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
  
  // MARK: - Custom Height
  
  private var customHeightListView: some View {
    
    List(0..<2, id: \.self) { item in
      Section {
        titleView(item)
      } header: {
        Text("Header")
      }
      .headerProminence(.increased)
      
      Section {
        titleView(item)
      } header: {
        Text("Body")
      }
    }
    .listStyle(.plain)
    .environment(\.defaultMinListRowHeight, 80)
    .environment(\.defaultMinListHeaderHeight, 20)
  }
  
  // MARK: - Custom Header
  
  private var customHeaderListView: some View {
    
    List(0..<1, id: \.self) { item in
      Section {
        titleView(item)
      } header: {
        Text("Header")
      }
      .headerProminence(.increased)
      
      Section {
        titleView(item)
      } header: {
        Text("Body")
          .font(.title2)
          .foregroundColor(.red)
      }
    }
    .listStyle(.plain)
    .environment(\.defaultMinListHeaderHeight, 20)
  }
  
  // MARK: - Custom List View Background
  
  private var customListBackgroundView: some View {
    List(0..<3, id: \.self) { item in
      titleView(item)
    }
    .scrollContentBackground(.hidden)
    .background(
      LinearGradient(colors: [.white, .blue], startPoint: .top, endPoint: .bottom)
        .blur(radius: 8)
    )
  }
  
  // MARK: - Custom List Row Background
  
  private var customListRowBackgroundView: some View {
    List(0..<3, id: \.self) { item in
      Text(String(describing: item))
        .listRowSeparator(.hidden)
        .listRowBackground(
          LinearGradient(colors: [.white, .red], startPoint: .leading, endPoint: .trailing)
            .padding(.vertical, 4)
        )   
    }
    .listStyle(.plain)
  }
}

struct CustomListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      CustomListView()
    }
  }
}
