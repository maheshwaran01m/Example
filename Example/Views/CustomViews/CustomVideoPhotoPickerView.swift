//
//  CustomVideoPhotoPickerView.swift
//  Example
//
//  Created by MAHESHWARAN on 27/08/23.
//

import SwiftUI
import AVFoundation
import PhotosUI
import AVKit

struct CustomVideoPhotoPickerView: View {
  
  @StateObject private var viewModel = AttachmentViewModel()
  
  var body: some View {
    VStack {
      if let selectedImage = viewModel.selectedImage {
        Image(uiImage: selectedImage)
          .resizable()
          .frame(width: 100, height: 100)
      }
      if let url = viewModel.selectedVideo {
        let player = AVPlayer(url: url)
        
        VideoPlayer(player: player)
          .frame(width: 640, height: 360)
          .onTapGesture {
            player.play()
          }
          .onReceive(viewModel.stopPlayer) { _ in
            player.seek(to: .zero)
            player.play()
          }
        
      }
      imagePickerView
      videoPicker
    }
  }
  
  
  private var imagePickerView: some View {
    PhotosPicker("Image", selection: $viewModel.photosPickerItem, matching: .any(of: [.images, .screenshots]))
      .buttonStyle(.bordered)
  }
  
  private var videoPicker: some View {
    PhotosPicker("Video", selection: $viewModel.photosPickerItem, matching: .any(of: [.videos, .screenRecordings]))
      .buttonStyle(.bordered)
  }
  
  
  /*
  private var imagePickerViewWithPastButton: some View {
    PhotosPicker("Image", selection: $viewModel.photosPickerItem, matching: .any(of: [.images, .screenshots]))
    .dropDestination(for: CustomImageTransfer.self) { items, _ in
      Task {
        if let image = items.first?.image {
          viewModel.selectedImage = image
        }
      }
      return !items.isEmpty
    }
    .overlayView {
      PasteButton(payloadType: CustomImageTransfer.self) { items in
        Task {
          if let image = items[0].image {
            viewModel.selectedImage = image
          }
        }
      }
      .labelStyle(.iconOnly)
      .buttonStyle(.borderless)
      .buttonBorderShape(.capsule)
    }
  }
  */
}


struct CustomVideoPhotoPickerView_Previews: PreviewProvider {
  static var previews: some View {
    CustomVideoPhotoPickerView()
  }
}

fileprivate class AttachmentViewModel: ObservableObject {
  
  @Published var photosPickerItem: PhotosPickerItem? {
    didSet {
      setPhotosPickerItem(for: photosPickerItem)
    }
  }
  
  @Published var videoPickerItem: PhotosPickerItem? {
    didSet {
      setVideoPickerItem(for: videoPickerItem)
    }
  }
  
  @Published private(set) var selectedImage: UIImage?
  @Published private(set) var selectedVideo: URL?
  
  let stopPlayer = NotificationCenter.default.publisher(for: NSNotification.Name.AVPlayerItemDidPlayToEndTime)
  
  private func setPhotosPickerItem(for selection: PhotosPickerItem?) {
    guard let selection else { return }
    
    selection.loadTransferable(type: CustomImageTransfer.self) { [weak self] result in
      guard let self else { return }
      Task {
        switch result {
        case .success(let data):
          if let uiImage = data?.image {
            DispatchQueue.main.async {
              self.selectedImage = uiImage
            }
          }
        case .failure(let error):
          print("Failed to import Image \(error)")
        }
      }
    }
    setVideoPickerItem(for: selection)
  }
  
  private func setVideoPickerItem(for selection: PhotosPickerItem?) {
    guard let selection else { return }
    selection.loadTransferable(type: Movie.self) { [weak self] result in
      guard let self else { return }
      Task {
        switch result {
        case .success(let url):
          if let url = url?.url {
            DispatchQueue.main.async {
              self.selectedVideo = url
            }
          }
        case .failure(let error):
          print("Failed to import Video \(error)")
        }
      }
    }
  }
  
  private struct CustomImageTransfer: Transferable {
    var image: UIImage?

    public static var transferRepresentation: some TransferRepresentation {
      DataRepresentation(importedContentType: .image) { data in
        let image = UIImage(data: data) ?? UIImage(systemName: "exclamationmark.triangle")
        return CustomImageTransfer(image: image)
      }
    }
  }
  
  private struct Movie: Transferable {
    let url: URL
    
    static var transferRepresentation: some TransferRepresentation {
      FileRepresentation(contentType: .movie) { movie in
        SentTransferredFile(movie.url)
      } importing: { received in
        let url = FileManager.default.temporaryDirectory.appendingPathComponent(received.file.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: url.path) {
          try FileManager.default.removeItem(at: url)
        }
        try FileManager.default.copyItem(at: received.file, to: url)
        
        return .init(url: url)
      }
    }
  }
}
