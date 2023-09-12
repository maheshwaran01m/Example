//
//  CustomQuickLookView.swift
//  Example
//
//  Created by MAHESHWARAN on 29/08/23.
//

import SwiftUI
import QuickLook

struct CustomQuickLookView: View {
  
  var body: some View {
    TabView {
      quickLookPreview
      quickLookEditView
    }
    .tabViewStyle(.page)
    .indexViewStyle(.page(backgroundDisplayMode: .always))
  }
  
  // MARK: - Preview
  
  @State private var url: URL? = nil
  
  var directory: URL {
    let directory = URL.documentsDirectory
    return directory.appending(path: "Example").appendingPathExtension("png")
  }
  
  var quickLookPreview: some View {
    Button("View File") {
      url = directory
    }
    .quickLookPreview($url)
  }
  
  // MARK: - Edit
  
  @State private var quickLookEdit = false
  @State private var selectedURLForQuickLook: URL?
  
  var quickLookEditView: some View {
    Text("Choose")
      .onTapGesture {
        quickLookEdit.toggle()
      }
      .sheet(isPresented: $quickLookEdit) {
        let url = URL(filePath: "\(URL.documentsDirectory.path())Files/Flower.png")
        QuickLookEditorView(url: url, selectedURL: $selectedURLForQuickLook)
      }
  }
}

struct CustomQuickLookView_Previews: PreviewProvider {
  static var previews: some View {
    CustomQuickLookView()
  }
}

// MARK: - QuickLookEditorView

public struct QuickLookEditorView: UIViewControllerRepresentable {
  
  public typealias Context = UIViewControllerRepresentableContext<Self>
  
  @Environment(\.dismiss) private var dismiss
  @Binding var selectedURL: URL?
  let url: URL?
  
  public init(url: URL?, selectedURL: Binding<URL?>) {
    self.url = url
    _selectedURL = selectedURL
  }
  
  public func makeUIViewController(context: Context) -> UIViewController {
    let preview = QLPreviewController()
    preview.dataSource = context.coordinator
    preview.delegate = context.coordinator
    preview.currentPreviewItemIndex = 0
    return UINavigationController(rootViewController: preview)
  }
  
  public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
  
  public func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  public class Coordinator: NSObject, QLPreviewControllerDataSource,
                            QLPreviewControllerDelegate {
    
    var parent: QuickLookEditorView?
    
    public init(_ parent: QuickLookEditorView?) {
      self.parent = parent
    }
    
    // MARK: - QLPreviewControllerDataSource
    
    public func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
      return 1
    }
    
    public func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
      PreviewItem(url: parent?.url, title: parent?.url?.lastPathComponent ?? "")
    }
    
    // MARK: - QLPreviewControllerDelegate
    
    public func previewController(_ controller: QLPreviewController,
                                  editingModeFor previewItem: QLPreviewItem) -> QLPreviewItemEditingMode {
      .createCopy
    }
    
    public func previewController(_ controller: QLPreviewController,
                                  didSaveEditedCopyOf previewItem: QLPreviewItem,
                                  at modifiedContentsURL: URL) {
      parent?.selectedURL = modifiedContentsURL
      parent?.dismiss()
    }
  }
  
  public class PreviewItem: NSObject, QLPreviewItem {
    public var previewItemURL: URL?
    public var previewItemTitle: String?
    
    public init(url: URL?, title: String?) {
      previewItemURL = url
      previewItemTitle = title
    }
  }
}
