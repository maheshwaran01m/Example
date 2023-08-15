//
//  CustomAsyncImageView.swift
//  Example
//
//  Created by MAHESHWARAN on 15/08/23.
//

import SwiftUI

struct CustomAsyncImageView: View {
  
  @State private var url: String?
  
  var body: some View {
    imageView
      .safeAreaInset(edge: .bottom, spacing: 30, content: buttonView)
  }
  
  private var imageView: some View {
    let exampleUrl = "https://techcrunch.com/wp-content/uploads/2023/04/mtn-5g-yellow-something.jpeg?resize=1200"
    return AsyncImage(url: URL(string: url ?? exampleUrl)) { image in
      image
        .resizable()
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .frame(width: 200, height: 200)
    } placeholder: {
      Image(systemName: "photo")
        .resizable()
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .frame(width: 200, height: 200)
        .foregroundStyle(Color.blue.opacity(0.4))
    }
  }
  
  private func buttonView() -> some View {
    Button("Change Button") {
      url = urls.randomElement()
    }
    .buttonStyle(.borderedProminent)
  }
}

struct CustomAsyncImageView_Previews: PreviewProvider {
  static var previews: some View {
    CustomAsyncImageView()
  }
}

extension CustomAsyncImageView {
  
  var urls: [String] {
    ["https://techcrunch.com/wp-content/uploads/2023/04/mtn-5g-yellow-something.jpeg?resize=1200",
     "https://techcrunch.com/wp-content/uploads/2021/01/GettyImages-503572806.jpg?resize=1200",
     "https://techcrunch.com/wp-content/uploads/2023/08/GettyImages-456086940.jpg?resize=1200",
     "https://techcrunch.com/wp-content/uploads/2023/04/Anthropic_logo_art.png?w=1080",
     "https://techcrunch.com/wp-content/uploads/2023/08/GettyImages-824832578.jpg?resize=1200",
     "https://techcrunch.com/wp-content/uploads/2023/06/TC-Disrupt-23-General-Article-Image-Header-1920x1080-6.png?resize=1200",
     "https://techcrunch.com/wp-content/uploads/2023/08/moovit-bugs-hackers.jpg?resize=1200",
     "https://techcrunch.com/wp-content/uploads/2022/02/GettyImages-993491068.jpg?resize=1200",
     "https://techcrunch.com/wp-content/uploads/2023/08/GettyImages-96260455.jpg?resize=1200",
     "https://techcrunch.com/wp-content/uploads/2023/04/mtn-5g-yellow-something.jpeg?resize=1200",
     "https://techcrunch.com/wp-content/uploads/2021/01/GettyImages-503572806.jpg?resize=1200",
     "https://techcrunch.com/wp-content/uploads/2023/08/GettyImages-456086940.jpg?resize=1200",
     "https://techcrunch.com/wp-content/uploads/2023/04/Anthropic_logo_art.png?w=1080",
     "https://techcrunch.com/wp-content/uploads/2023/08/ultrahuman-smart-ring.jpg?w=1200",
     "https://techcrunch.com/wp-content/uploads/2023/08/GettyImages-824832578.jpg?resize=1200",
     "https://techcrunch.com/wp-content/uploads/2023/08/moovit-bugs-hackers.jpg?resize=1200",
     "https://techcrunch.com/wp-content/uploads/2022/02/GettyImages-993491068.jpg?resize=1200",
     "https://techcrunch.com/wp-content/uploads/2023/08/GettyImages-96260455.jpg?resize=1200"]
  }
}
