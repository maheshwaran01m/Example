//
//  CustomDialogAlertView.swift
//  Examples
//
//  Created by MAHESHWARAN on 12/08/23.
//

import SwiftUI
import PhotosUI

struct CustomDialogAlertView: View {
  
  var body: some View {
    TabView {
      customPhotoPicker
      customBackgroundView
    }
  }
  
  // MARK: - PhotoPicker
  
  @State private var isPresented = false
  @State private var photoPicker: PhotosPickerItem?
  @State private var showVideo = false
  @State private var showPhoto = false
  @State private var showFiles = false
  
  var customPhotoPicker: some View {
    Button("Choose Files") {
      isPresented.toggle()
    }
    .confirmationDialog("Choose Source Type", isPresented: $isPresented, titleVisibility: .visible) {
      Button("Photo") {
        showPhoto.toggle()
      }
      Button("Video") {
        showVideo.toggle()
      }
      Button("Documents") {
        showFiles.toggle()
      }
    }
    .photosPicker(isPresented: $showPhoto, selection: $photoPicker)
    .photosPicker(isPresented: $showVideo, selection: $photoPicker)
    .fileImporter(isPresented: $showFiles, allowedContentTypes: [
      .image, .video, .text, .pdf, .movie, .png, .presentation, .spreadsheet],
                  allowsMultipleSelection: false) { result in
      switch result {
      case .success(let files):
        let file = files[0]
        if file.startAccessingSecurityScopedResource() {
          print("File: \(file.path())")
          file.stopAccessingSecurityScopedResource()
        }
      case .failure(let failure):
        print(failure)
      }
    }
  }
  
  // MARK: - customBackgroundView
  
  @State private var showingConfirmation = false
  @State private var backgroundColor = Color.white
  
  var customBackgroundView: some View {
    Text("Choose Background color")
      .foregroundStyle(.linearGradient(colors: [.red, .yellow], startPoint: .leading, endPoint: .trailing))
      .frame(width: 300, height: 300)
      .background(backgroundColor)
      .onTapGesture {
        showingConfirmation = true
      }
      .confirmationDialog("Change background", isPresented: $showingConfirmation, titleVisibility: .visible) {
        Button("Gray") { backgroundColor = .gray }
        Button("Green") { backgroundColor = .green.opacity(0.3) }
        Button("Blue") { backgroundColor = .blue.opacity(0.2) }
        Button("Cancel", role: .cancel) { }
      } message: {
        Text("Select a new color")
      }
  }
}

struct CustomDialogAlertView_Previews: PreviewProvider {
  static var previews: some View {
    CustomDialogAlertView()
  }
}
