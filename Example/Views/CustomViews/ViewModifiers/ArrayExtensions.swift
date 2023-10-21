//
//  ArrayExtensions.swift
//  Example
//
//  Created by MAHESHWARAN on 21/10/23.
//

import Foundation

extension Array {
  
  func sorted<T: Comparable>(_ keyPath: KeyPath<Element, T>, ascending: Bool = true) -> [Element] {
    self.sorted {
      ascending ? $0[keyPath: keyPath] < $1[keyPath: keyPath] : $0[keyPath: keyPath] > $1[keyPath: keyPath]
    }
  }
  
  mutating func sortBy<T: Comparable>(_ keyPath: KeyPath<Element, T>, ascending: Bool = true) {
    self.sort {
      ascending ? $0[keyPath: keyPath] < $1[keyPath: keyPath] : $0[keyPath: keyPath] > $1[keyPath: keyPath]
    }
  }
}
