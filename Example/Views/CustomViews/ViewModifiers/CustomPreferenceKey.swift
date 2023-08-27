//
//  CustomPreferenceKey.swift
//  Example
//
//  Created by MAHESHWARAN on 27/08/23.
//

import SwiftUI

// MARK: - PreferenceKey

public struct HeightPreferenceKey: PreferenceKey {
  public typealias Value = CGFloat
  public static var defaultValue: CGFloat = 0.0
    
  public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value = nextValue()
  }
}
