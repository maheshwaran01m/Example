//
//  CustomTabView.swift
//  Examples
//
//  Created by MAHESHWARAN on 12/08/23.
//

import SwiftUI

struct CustomTabView: View {
  var body: some View {
    TabView {
      homeView
      tabViewBadge
    }
  }
  
  // MARK:  Tab
  private var homeView: some View {
    Text("Home")
      .tabItem {
        Label("Home", systemImage: "house")
      }
      .badge("Home")
  }
  
  private var tabViewBadge: some View {
    Text("Settings")
      .tabItem {
        Label("Settings", systemImage: "gear")
      }
      .badge(5)
      .tabViewStyle(.page)
      .indexViewStyle(.page(backgroundDisplayMode: .always))
  }
  
  // MARK: Page
  private var pageView: some View {
    TabView {
      Text("Page")
    }
    .tabViewStyle(.page)
    .indexViewStyle(.page(backgroundDisplayMode: .always))
  }
}

struct CustomTabView_Previews: PreviewProvider {
  static var previews: some View {
    CustomTabView()
  }
}
