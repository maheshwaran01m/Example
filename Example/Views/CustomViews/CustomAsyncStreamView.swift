//
//  CustomAsyncStreamView.swift
//  Example
//
//  Created by MAHESHWARAN on 24/11/23.
//

import SwiftUI

struct CustomAsyncStreamView: View {
  
  @StateObject private var viewModel = CustomAsyncStreamViewModel()
  
  var body: some View {
    Text(viewModel.currentNumber.description)
  }
}

#Preview {
  CustomAsyncStreamView()
}

@MainActor
class CustomAsyncStreamViewModel: ObservableObject {
  
  @Published private(set) var currentNumber: Int = 0

  let manager = CustomAsyncStreamManager()
  
  init() {
    getCurrentData()
  }
  
  func getCurrentData() {
//    manager.getData { [weak self] value in
//      self?.currentNumber = value
//    }
    
    
   let task = Task {
      for await value in manager.getAsyncStream() {
        currentNumber = value
      }
    }
    
    /*
    Task {
      do {
        for try await value in manager.getAsyncThrowingStream() {
          currentNumber = value
        }
      } catch {
        print(error.localizedDescription)
      }
    }
    */
    
    // Cancel task
    DispatchQueue.main.asyncAfter(deadline: .now() + 11) {
      task.cancel()
    }
  }
}

class CustomAsyncStreamManager {
  
  func getAsyncStream() -> AsyncStream<Int> {
    .init(Int.self) { continuation in
      let records = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
      
      for record in records {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(record)) {
          continuation.yield(record)
          
          if record == records.last {
            continuation.finish()
          }
        }
      }
    }
  }
  
  func getAsyncThrowingStream() -> AsyncThrowingStream<Int, Error> {
    .init(Int.self) { continuation in
      let records = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
      
      for record in records {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(record)) {
          continuation.yield(record)
          
          if record == records.last {
            let isError = Bool.random()
            let errorMessage = URLError(.badURL)
            
            continuation.finish(throwing: isError ? errorMessage : nil)
          }
        }
      }
    }
  }
  
  func getData(_ completion: @escaping (Int) -> ()) {
    let records = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    for record in records {
      DispatchQueue.main.asyncAfter(deadline: .now() + Double(record)) {
        completion(record)
      }
    }
  }
}
