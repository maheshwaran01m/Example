//
//  CustomTimeLineView.swift
//  Example
//
//  Created by MAHESHWARAN on 15/11/23.
//

import SwiftUI

struct CustomTimeLineView: View {
  
  var body: some View {
    VStack(spacing: 20) {
      timeLineView
      playButton
    }
  }
  
  @State private var pauseAnimation = false

  private var timeLineView: some View {
    TimelineView(.animation(minimumInterval: 1, paused: pauseAnimation)) { context in
      Text("Date: \(context.date.description)")
      
      let seconds = Calendar.current.component(.second, from: context.date)
      Text(seconds.description)
      Rectangle()
        .frame(width: seconds < 10 ? 50 : seconds < 30 ? 200 : 400,
               height: 100)
        .animation(.bouncy, value: seconds)
    }
  }
  
  private var playButton: some View {
    Button(pauseAnimation ? "Play" : "Pause") {
      pauseAnimation.toggle()
    }
    .buttonStyle(.borderedProminent)
  }
}

#Preview {
  CustomTimeLineView()
}
