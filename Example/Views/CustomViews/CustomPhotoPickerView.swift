//
//  CustomPhotoPickerView.swift
//  Examples
//
//  Created by MAHESHWARAN on 06/08/23.
//

import SwiftUI
import PhotosUI

struct CustomPhotoPickerView: View {
  
  var body: some View {
    photoPickerView
  }
  
  // MARK: - Photo Picker
  
  @State private var avatarItem: PhotosPickerItem?
  @State private var avatarImage: Image?
  
  var photoPickerView: some View {
    VStack {
      if let avatarImage {
        avatarImage
          .resizable()
          .scaledToFit()
          .clipShape(RoundedRectangle(cornerRadius: 8))
          .frame(width: 300, height: 300)
        
      }
      PhotosPicker("Select Photo", selection: $avatarItem, matching: .images)
    }
    .onChange(of: avatarItem) { _ in
      Task {
        if let data = try? await avatarItem?.loadTransferable(type: Data.self) {
          if let uiImage = UIImage(data: data) {
            avatarImage = Image(uiImage: uiImage)
            return
          }
        }
        print("Failed")
      }
    }
  }
}

struct CustomPhotoPickerView_Previews: PreviewProvider {
  static var previews: some View {
    CustomPhotoPickerView()
  }
}
