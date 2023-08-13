//
//  ExampleApp.swift
//  Example
//
//  Created by MAHESHWARAN on 13/08/23.
//

import SwiftUI

@main
struct ExampleApp: App {
  var body: some Scene {
    WindowGroup {
      let _ = print("Path: \(URL.libraryDirectory.path())")
      ContentView()
    }
  }
}
