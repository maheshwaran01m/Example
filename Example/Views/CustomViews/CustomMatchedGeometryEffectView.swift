//
//  CustomMatchedGeometryEffectView.swift
//  Examples
//
//  Created by MAHESHWARAN on 10/08/23.
//

import SwiftUI

struct CustomMatchedGeometryEffectView: View {
  
  @Namespace private var showAnimation
  @State private var canMerge = false
  
  var body: some View {
    VStack(spacing: 10) {
      HStack {
        Rectangle()
          .matchedGeometryEffect(id: "effectView", in: showAnimation, isSource: true)
          .frame(width: 100, height: 70)
          .foregroundStyle(Color.blue.opacity(0.6))
        
        Rectangle()
          .matchedGeometryEffect(id: canMerge ? "effectView" :  "", in: showAnimation, isSource: false)
          .frame(width: 70, height: 50)
          .foregroundStyle(Color.cyan.opacity(0.6))
      }
      
      Button("Match") {
        withAnimation(.spring()) {
          canMerge.toggle()
        }
      }
      .buttonStyle(.borderedProminent)
    }
  }
}

struct CustomMatchedGeometryEffectView_Previews: PreviewProvider {
  static var previews: some View {
    CustomMatchedGeometryEffectView()
  }
}
