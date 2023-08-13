//
//  CustomTimerView.swift
//  Examples
//
//  Created by MAHESHWARAN on 12/08/23.
//

import SwiftUI

struct CustomTimerView: View {
  
  @State var startDate = Date.now
  @State var timeElapsed: Int = 0
  
  @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  
  var body: some View {
    VStack {
      timerView
      actionButtons
    }
    .font(.headline)
  }
  
  private var timerView: some View {
    Text("Time elapsed: \(timeElapsed) sec")
    // even spacing between digits
      .monospacedDigit()
      .onReceive(timer) { firedDate in
        timeElapsed = Int(firedDate.timeIntervalSince(startDate))
      }
  }
  
  private var actionButtons: some View {
    HStack {
      
      Button("Resume") {
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
      }
      
      Button("Stop") {
        timer.upstream.connect().cancel()
      }
      .foregroundColor(.red)
    }
    .buttonStyle(.bordered)
  }
}

struct CustomTimerView_Previews: PreviewProvider {
  static var previews: some View {
    CustomTimerView()
  }
}
