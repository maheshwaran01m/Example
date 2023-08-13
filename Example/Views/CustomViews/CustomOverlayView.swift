//
//  CustomOverlayView.swift
//  Examples
//
//  Created by MAHESHWARAN on 12/08/23.
//

import SwiftUI

struct CustomOverlayView: View {
  
  var body: some View {
    overlayView
  }
  
  @State private var isLoading = false
  
  var overlayView: some View {
    Text("SwiftUI")
      .foregroundColor(.blue)
      .font(.title)
      .padding(35)
      .background(
        LinearGradient(
          colors: [.orange.opacity(0), .orange.opacity(0.6), .red.opacity(0.8)],
          startPoint: .topLeading,
          endPoint: .bottomTrailing
        )
      )
      .onTapGesture {
        self.isLoading.toggle()
      }
      .overlay(starOverlay, alignment: .topTrailing)
      .overlay {
        if isLoading {
          ZStack {
            Color(white: 0, opacity: 0.75)
            ProgressView().tint(.white)
          }
          .onTapGesture {
            self.isLoading = false
          }
        }
      }
      .cornerRadius(20)
  }
  
  private var starOverlay: some View {
    Image(systemName: "star")
      .foregroundColor(.black)
      .padding([.top, .trailing], 5)
  }
}

struct CustomOverlayView_Previews: PreviewProvider {
  static var previews: some View {
    CustomOverlayView()
  }
}
