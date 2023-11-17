//
//  TimeInterval.swift
//  Example
//
//  Created by MAHESHWARAN on 17/11/23.
//

import Foundation

extension Double {
  
  func formattedString(_ units : NSCalendar.Unit = [.hour, .minute],
                       style: DateComponentsFormatter.UnitsStyle = .full) -> String {
    
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = units
    formatter.unitsStyle = style
    
    return formatter.string(from: self) ?? ""
  }
}
