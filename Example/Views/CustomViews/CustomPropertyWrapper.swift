//
//  CustomPropertyWrapper.swift
//  Example
//
//  Created by MAHESHWARAN on 01/09/23.
//

import SwiftUI
import Combine

struct CustomPropertyWrapper: View {
  
  var body: some View {
    TabView {
      fileManagerPropertyView
      stringFormatView
      capitalizedView
    }
    .tabViewStyle(.page)
    .indexViewStyle(.page)
  }
  
  // MARK: - StringFormat
  
  @StringFormat(format: .lowercased) private var text = ""
  
  var stringFormatView: some View {
    VStack {
      Text(text)
      TextField("Enter", text: $text)
    }
    .padding(.horizontal)
  }
  
  // MARK: - FileManagerProperty
  
  //  @FileManagerProperty("fileManagerProperty") private var user: User?
  @FileManagerProperty(\.key) private var user: User?
  
  var fileManagerPropertyView: some View {
    VStack(spacing: 10) {
      Text(user?.title ?? "")
      Text(user?.subtitle ?? "")
      
      Button("Save") {
        user = .init(title: "title \(Int.random(in: 0...20))",
                     subtitle: "subtitle \(Int.random(in: 0...20))")
      }
      .buttonStyle(.borderedProminent)
      .padding()
    }
    .onReceive(user.publisher) { value in
      print("User: \(value.title)")
    }
    .task {
      for await newValue in user.publisher.values {
        print("User: \(newValue.title)")
      }
    }
  }
  
  // MARK: - Capitalized
  
  @Capitalized private var value: String = "hello"
  
  var capitalizedView: some View {
    VStack {
      Button(value) {
        value = "NewValue \(Int.random(in: 0...20))"
      }
    }
  }
  
  struct User: Codable {
    var title: String
    var subtitle: String
  }
  
  struct Keys {
    let key = "userProfile"
    let type: User.Type
  }
}

struct CustomPropertyWrapper_Previews: PreviewProvider {
  static var previews: some View {
    CustomPropertyWrapper()
  }
}

// MARK: - StringFormat

@propertyWrapper
struct StringFormat: DynamicProperty {
  
  @State private var value: String = ""
  private var format: Format = .default
  
  enum Format {
    case lowercased, uppercased, capitalized, `default`
  }
  init(wrappedValue: String, format: Format = .default) {
    self.wrappedValue = wrappedValue
    self.format = format
  }
  
  var wrappedValue: String {
    get { value }
    nonmutating set { value = formattedString(newValue) }
  }
  
  var projectedValue: Binding<String> {
    Binding(
      get: { wrappedValue },
      set: { wrappedValue = $0 }
    )
  }
  
  private func formattedString(_ string: String) -> String {
    switch format {
    case .capitalized:
      return string.capitalized
    case .lowercased:
      return string.lowercased()
    case .uppercased:
      return string.uppercased()
    case .default:
      return string
    }
  }
}

@propertyWrapper
struct Capitalized: DynamicProperty {
  @State private var value: String
  
  init(wrappedValue: String) {
    self.value = wrappedValue
  }
  
  var wrappedValue: String {
    get {
      value
    } nonmutating set {
      value = newValue
    }
  }
  
  var projectedValue: Binding<String> {
    .init {
      wrappedValue
    } set: {
      wrappedValue = $0
    }
  }
}

@propertyWrapper
struct FileManagerProperty<T: Codable>: DynamicProperty {
  
  @State private var value: T?
  let key: String
  
  var wrappedValue: T? {
    get { value } nonmutating set { save(newValue) }
  }
  
  // MARK: - ProjectedValue
  
  var projectedValue: Binding<T?> {
    .init { wrappedValue } set: { wrappedValue = $0 }
  }
  
  // MARK: - Init
  
  init(wrappedValue: T? = nil, _ key: String) {
    self.key = key
    
    do {
      let filePath = URL.documentsDirectory.appending(path: "\(key).txt")
      
      let data = try Data(contentsOf: filePath)
      let value = try JSONDecoder().decode(T.self, from: data)
      
      publisher = .init(value)
      _value = .init(initialValue: value)
    } catch {
//      print("Error while reading document, reason: \(error.localizedDescription)")
      publisher = .init(nil)
      _value = .init(initialValue: wrappedValue ?? nil)
    }
  }
  
  init(_ keyPath: KeyPath<FileValues, FileKeyPath<T>>) {
    self.key = FileManagerProperty<T>.FileValues()[keyPath: keyPath].key
    
    do {
      let filePath = URL.documentsDirectory.appending(path: "\(key).txt")
      
      let data = try Data(contentsOf: filePath)
      let value = try JSONDecoder().decode(T.self, from: data)
      
      publisher = .init(value)
      _value = .init(initialValue: value)
    } catch {
//      print("Error while reading document, reason: \(error.localizedDescription)")
      publisher = .init(nil)
      _value = .init(initialValue: wrappedValue ?? nil)
    }
  }
  
  struct FileKeyPath<K: Codable> {
    let key: String
    let type: K.Type
  }
  
  struct FileValues {
    init() {}
    
    let key = FileKeyPath(key: "user_profile", type: T.self)
  }
  
  // MARK: - Custom Methods
  
  private func save(_ newValue: T?) {
    do {
      let data = try JSONEncoder().encode(newValue)
      let filePath = URL.documentsDirectory.appending(path: "\(key).txt")
      
      try data.write(to: filePath)
      value = newValue
      publisher.send(value)
    } catch {
      print("Error while saving document, reason: \(error.localizedDescription)")
    }
  }
  
  // MARK: - Combine
  
  public var publisher: CurrentValueSubject<T?, Never>
  
  public var stream: AsyncPublisher<CurrentValueSubject<T?, Never>> {
    publisher.values
  }
  
  struct ProjectedValue<K: Codable> {
    let binding: Binding<K?>
    let publisher: CurrentValueSubject<K?, Never>
    
    var stream: AsyncPublisher<CurrentValueSubject<K?, Never>> {
      publisher.values
    }
  }
   
  /*
   var projectedValue: ProjectedValue<T> {
   .init(binding: .init { wrappedValue } set: { wrappedValue = $0 }, publisher: publisher)
   }
   */
}
