//
//  CustomButtonView.swift
//  Examples
//
//  Created by MAHESHWARAN on 06/08/23.
//

import SwiftUI

struct CustomButtonView: View {
  
  var body: some View {
    TabView {
      saveButtonViews
      buttonViewExamples
      buttonWithLabel
      buttonTapAction
      loginButtons
    }
    .tabViewStyle(.page)
    .indexViewStyle(.page(backgroundDisplayMode: .always))
  }
  
  private var buttonViewExamples: some View {
    VStack {
      Button("Button 1") { }
        .buttonStyle(.bordered)
      Button("Button 2", role: .destructive) { }
        .buttonStyle(.bordered)
      Button("Button 3") { }
        .buttonStyle(.borderedProminent)
      Button("Button 4", role: .destructive) { }
        .buttonStyle(.borderedProminent)
    }
  }
  
  private var buttonWithLabel: some View {
    VStack {
      Button {
        print("Button was tapped")
      } label: {
        Text("Tap me!")
          .padding()
          .foregroundColor(.white)
          .background(.red)
          .clipShape(Capsule())
      }
      
      // label
      Button {
        print("Edit button was tapped")
      } label: {
        Label("Edit", systemImage: "pencil")
          .monospaced()
      }
      .buttonStyle(.bordered)
    }
  }
  
  @State private var tapCount = 0
  
  private var buttonTapAction: some View {
    Button("Tap Count: \(tapCount)") {
      self.tapCount += 1
    }
    .buttonBorderShape(.automatic)
    .buttonStyle(.bordered)
  }
  
  private var loginButtons: some View {
    VStack {
      Button { } label: {
        Text("Log in")
          .foregroundColor(.white)
          .padding()
          .frame(maxWidth: .infinity)
          .background(.blue)
          .clipShape(Capsule())
          .contentShape(Capsule())
      }
      
      Button { } label: {
        Text("Rest Password")
          .foregroundColor(.white)
          .padding()
          .frame(maxWidth: .infinity)
          .background(.gray.opacity(0.8))
          .clipShape(Capsule())
          .contentShape(Capsule())
      }
    }
    .fixedSize(horizontal: true, vertical: false)
  }
  
  private var saveButtonViews: some View {
    HStack(spacing: 5) {
      "Cancel"
        .font(.title3)
        .padding()
        .frame(maxWidth: .infinity)
        .foregroundColor(Color.primary)
        .background(Color.blue.opacity(0.1),
                    in: Capsule())
        .background(
          Capsule()
            .stroke(Color.secondary, lineWidth: 1.5)
        )
      
      "Save"
        .font(.title3)
        .padding()
        .frame(maxWidth: .infinity)
        .foregroundColor(Color.white)
        .background(Color.blue,
                    in: Capsule())
        .background(
          Capsule()
            .stroke(Color.secondary, lineWidth: 1.5)
        )
    }
    .padding(.horizontal)
  }
}

struct CustomButtonView_Previews: PreviewProvider {
  static var previews: some View {
    CustomButtonView()
  }
}
