//
//  CustomTimerView.swift
//  Examples
//
//  Created by MAHESHWARAN on 12/08/23.
//

import SwiftUI

struct CustomTimerView: View {
  
  var body: some View {
    TabView {
      stopWatchTimerView
      secondTimerView
    }
    .tabViewStyle(.page)
    .indexViewStyle(.page(backgroundDisplayMode: .always))
  }
  
  // MARK: - Timer
  @State private var isTimerEnabled = false {
    didSet {
      if isTimerEnabled {
        resetTimer()
      } else {
        startTimer()
      }
    }
  }
  @State var elapsedTime: TimeInterval = 0
  @State var stopWatchtimer: Timer?
  
  private var stopWatchTimerView: some View {
    Text(timerString /*elapsedTime.timerString*/)
      .font(.title)
      .foregroundColor(.primary)
      .frame(height: 24)
      .monospacedDigit()
      .multilineTextAlignment(.center)
      .onTapGesture {
        isTimerEnabled.toggle()
      }
  }
  
  var timerString: String {
    let minutes = Int(elapsedTime) / 60 % 60
    let seconds = Int(elapsedTime) % 60
    let milliseconds = Int(elapsedTime * 100) % 100
    return String(format: "%02d:%02d:%02d", minutes, seconds, milliseconds)
  }
  
  private func startTimer() {
    resetTimer()
    stopWatchtimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
      self.elapsedTime += timer.timeInterval
    }
  }
  
  private func resetTimer() {
    elapsedTime = 0
    stopWatchtimer?.invalidate()
    stopWatchtimer = nil
  }
  
  // MARK: - seconds Timer
  
  @State var startDate = Date.now
  @State var timeElapsed: Int = 0
  
  @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  
  var secondTimerView: some View {
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

public extension TimeInterval {
  
  var timerString: String {
    let minutes = Int(self) / 60 % 60
    let seconds = Int(self) % 60
    let milliseconds = Int(self * 100) % 100
    return String(format: "%02d:%02d:%02d", minutes, seconds, milliseconds)
  }
}
