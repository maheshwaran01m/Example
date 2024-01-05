//
//  CustomImageCacheView.swift
//  Example
//
//  Created by MAHESHWARAN on 24/10/23.
//

import SwiftUI

struct CustomImageCacheView: View {
  
  @StateObject private var viewModel = CacheViewModel()
  
  var body: some View {
    VStack(spacing: 15) {
      
      HStack {
        if let image = viewModel.image {
          Image(uiImage: image)
            .renderingMode(.original)
            .resizable()
            .scaledToFill()
            .frame(width: 150, height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(alignment: .topTrailing) {
              Image(systemName: "star.fill")
                .foregroundStyle(Color.yellow)
                .padding([.trailing, .top], 2)
            }
        }
        
        if let image = viewModel.cachedImage {
          Image(uiImage: image)
            .renderingMode(.original)
            .resizable()
            .scaledToFill()
            .frame(width: 150, height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
      }
      buttonViews
    }
  }
  
  private var buttonViews: some View {
    HStack {
      Button(action: viewModel.removeFromChache) {
        Text("Delete")
          .font(.headline)
          .foregroundStyle(Color.primary)
          .padding()
          .background(Color.red
            .clipShape(RoundedRectangle(cornerRadius: 8)))
      }
      
      Button(action: viewModel.saveToChache) {
        Text("Save")
          .font(.headline)
          .foregroundStyle(Color.primary)
          .padding()
          .background(Color.blue
            .clipShape(RoundedRectangle(cornerRadius: 8)))
      }
      
      Button(action: viewModel.getFromChache) {
        Text("Get")
          .font(.headline)
          .foregroundStyle(Color.primary)
          .padding()
          .background(Color.green
            .clipShape(RoundedRectangle(cornerRadius: 8)))
      }
    }
  }
}

#Preview {
  CustomImageCacheView()
}

// MARK: - CacheViewModel

private class CacheViewModel: ObservableObject {
  
  @Published var image: UIImage?
  @Published var cachedImage: UIImage?
  
  let imageName = "cacheImage"
  
  let manager = CacheManager.shared
  
  init() {
    setupImage()
  }
  
  private func setupImage() {
    image = .init(named: "water")
  }
  
  func saveToChache() {
    guard let image else { return }
    manager.add(image, name: imageName)
    cachedImage = manager.get(imageName)
  }
  
  func removeFromChache() {
    manager.remove(imageName)
    cachedImage = manager.get(imageName)
  }
  
  func getFromChache() {
    cachedImage = manager.get(imageName)
  }
}

// MARK: - CacheManager

private class CacheManager {
  
  static let shared = CacheManager()
  private init() {}
  
  var imageCache: NSCache<NSString, UIImage> = {
    let cache = NSCache<NSString, UIImage>()
    cache.countLimit = 10
    cache.totalCostLimit = 1024 * 1024 * 10
    return cache
  }()
  
  func add(_ image: UIImage, name: String) {
    imageCache.setObject(image, forKey: .init(string: name))
  }
  
  func remove(_ name: String) {
    imageCache.removeObject(forKey: .init(string: name))
  }
  
  func get(_ name: String) -> UIImage? {
    imageCache.object(forKey: .init(string: name))
  }
}
