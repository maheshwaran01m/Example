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
        RoundedRectangle(cornerRadius: 8)
          .matchedGeometryEffect(id: "effectView", in: showAnimation, isSource: true)
          .frame(width: 200, height: 170)
          .foregroundStyle(Color.blue.opacity(0.6))
        
        RoundedRectangle(cornerRadius: 8)
          .matchedGeometryEffect(id: canMerge ? "effectView" :  "", in: showAnimation, isSource: false)
          .frame(width: 170, height: 150)
          .foregroundStyle(Color.red.opacity(0.6))
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
