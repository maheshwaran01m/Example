//
//  CustomNavigationTransitionView.swift
//  Example
//
//  Created by MAHESHWARAN on 03/11/23.
//

import SwiftUI

struct CustomNavigationTransitionView: View {
  
  var body: some View {
    TabView {
      exampleViewThree
      exampleViewTwo
      exampleViewOne
    }
    .tabViewStyle(.page)
    .indexViewStyle(.page(backgroundDisplayMode: .always))
  }
  
  // MARK: - Example One
  
  @State private var isEnabled = true
  
  var exampleViewOne: some View {
    ZStack {
      Text("First View")
        .onTapGesture {
          withAnimation {
            isEnabled.toggle()
          }
        }
      
      if isEnabled {
        SecondView(isEnabled: $isEnabled)
          .transition(.move(edge: .trailing))
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
  
  struct SecondView: View {
    
    @Binding var isEnabled: Bool
    
    var body: some View {
      ZStack {
        Color.pink
        
        Text("Second View")
          .padding()
          .background(Color.blue.opacity(0.3))
          .clipShape(Capsule())
          .onTapGesture {
            withAnimation {
              isEnabled.toggle()
            }
          }
      }
    }
  }
  
  // MARK: - Example Two
  
  @StateObject var viewModel = ExampleViewModel()
  
  var exampleViewTwo: some View {
    ZStack {
      Text("First View \(viewModel.selectedItem ?? 0)")
        .onTapGesture {
          withAnimation {
            viewModel.isEnabled.toggle()
          }
        }
      
      if viewModel.isEnabled {
        SecondExampleView(selectedItem: $viewModel.selectedItem)
          .transition(.move(edge: .trailing))
          .onChange(of: viewModel.selectedItem) { _ in
            withAnimation {
              viewModel.isEnabled = false
            }
          }
      }
    }
  }
  
  // MARK: - Example Three
  
  @State private var isPresented = false
  
  var exampleViewThree: some View {
    ZStack {
      Text("Thrid View")
        .padding()
        .background(Color.blue.opacity(0.3))
        .clipShape(Capsule())
        .onTapGesture {
          withAnimation(.linear.speed(2)) {
            isPresented.toggle()
          }
        }
      
      if isPresented {
        Color.pink.opacity(0.3)
          .transition(.move(edge: .trailing))
          .onTapGesture {
            withAnimation(.linear.speed(2)) {
              isPresented.toggle()
            }
          }
      }
    }
  }
}

extension CustomNavigationTransitionView {
  
  struct SecondExampleView: View {
    @Binding var selectedItem: Int?
    
    var body: some View {
      VStack {
        List (0..<29, id: \.self, selection: $selectedItem) { item in
          Text(String(item))
            .onTapGesture {
              selectedItem = item
              debugPrint("Item: \(item)")
            }
        }
      }
    }
  }
  
  class ExampleViewModel: ObservableObject {
    @Published var isEnabled = true
    @Published var selectedItem: Int?
  }
}

#Preview {
  CustomNavigationTransitionView()
}
