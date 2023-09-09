//
//  CustomNotificationObserverView.swift
//  Example
//
//  Created by MAHESHWARAN on 05/09/23.
//

import SwiftUI

struct CustomNotificationObserverView: View {
  
  @StateObject private var viewModel = ExampleViewModel()
  
  var body: some View {
    VStack {
      Text(viewModel.example)
      
      Button {
        viewModel.isPresented.toggle()
      } label: {
        Text("Hello")
      }
      .onReceiveNotification(for: .showAttachmentFileNameAlert) { (value: ExampleView2.ExampleData) in
        viewModel.example = value.title
      }
      .sheet(isPresented: $viewModel.isPresented) {
        ExampleView2()
      }
    }
  }
}

struct CustomNotificationObserverView_Previews: PreviewProvider {
  static var previews: some View {
    CustomNotificationObserverView()
  }
}

class ExampleViewModel: ObservableObject {
  @Published var example: String = "Example Data"
  @Published var isPresented = false
}

struct ExampleView2: View {
  @Environment(\.dismiss) private var dismiss
  
  struct ExampleData {
    let title = "example data"
  }
  
  var body: some View {
    Button ("Change") {
      NotificationCenter.default.post(name: .showAttachmentFileNameAlert, object: ExampleData())
      dismiss()
    }
  }
}

// MARK: - NotificationCenter

public extension View {
  
  func onReceiveNotification<T>(for name: Notification.Name,
                                content: @escaping (T) -> Void) -> some View {
    self.onReceive(NotificationCenter.default.publisher(for: name)) { notification in
      if let data = notification.object as? T {
        content(data)
      }
    }
  }
}

public extension Notification.Name {
  static let showAttachmentFileNameAlert = Notification.Name("showAttachmentFileNameAlert")
}

public extension NotificationCenter {
  
  func postMainThread<T>(name: Notification.Name, object: T?,
                      userInfo: [AnyHashable : T]? = nil) {
    DispatchQueue.main.async {
      self.post(name: name, object: object, userInfo: userInfo)
    }
  }
}
