//
//  CustomLayoutView.swift
//  Example
//
//  Created by MAHESHWARAN on 26/08/23.
//

import SwiftUI

struct CustomLayoutView: View {
  
  var body: some View {
    changeLayoutTypeView
  }
  
  // MARK: - Change LayoutType
  
  @State private var layoutType = LayoutType.zStack
  
  private var changeLayoutTypeView: some View {
    AnyLayout(layoutType.layout) {
      contentView
    }
    .toolbar(content: changeLayoutButton)
  }
  
  private var contentView: some View {
    ForEach(ColorView.allColors, id: \.color) { view in
      view.color
        .frame(width: view.width, height: view.height)
    }
  }
  
  @ToolbarContentBuilder
  private func changeLayoutButton() -> some ToolbarContent {
    ToolbarItem(placement: .navigationBarTrailing) {
      
      Button(action: changeLayoutButtonAction) {
        Image(systemName: "circle.grid.3x3.circle")
          .imageScale(.large)
      }
    }
  }
  
  private func changeLayoutButtonAction() {
    withAnimation {
      if layoutType.index < LayoutType.allCases.count - 1 {
        layoutType = LayoutType.allCases[layoutType.index + 1]
      } else {
        layoutType = LayoutType.allCases[0]
      }
    }
  }
  
  enum LayoutType: Int, CaseIterable {
    case zStack, hStack, hStackTop, vStack, vStackTrailing,
         customStack, customHStack, customVStack
    
    var index: Int {
      LayoutType.allCases.firstIndex(where: { $0 == self }) ?? 0
    }
    
    var layout: any Layout {
      switch self {
      case .zStack: return ZStackLayout()
      case .hStack: return HStackLayout()
      case .hStackTop: return HStackLayout(alignment: .top, spacing: 5)
      case .vStack: return VStackLayout()
      case .vStackTrailing: return VStackLayout(alignment: .trailing)
      case .customStack: return AlternativeStackLayout()
      case .customHStack: return CustomHStack(rows: 20, spacing: 5)
      case .customVStack: return CustomVStack(columns: 5, spacing: 5)
      }
    }
  }
  
  struct ColorView {
    var color: Color
    var width: CGFloat
    var height: CGFloat
    
    static var allColors: [ColorView] {
      [.init(color: .red, width: 60, height: 75),
       .init(color: .teal, width: 100, height: 100),
       .init(color: .purple, width: 40, height: 80),
       .init(color: .indigo, width: 120, height: 100)]
    }
  }
  
  // MARK: - Custom Protocol View
  
  struct AlternativeStackLayout: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
      guard !subviews.isEmpty else { return .zero }
      let subviews = subviews.map { $0.sizeThatFits(.unspecified) }
      let width = subviews.map { $0.width }
      
      let evenWidth = width.enumerated().filter { $0.0.isMultiple(of: 2)}.map { $0.1 }.max()
      let oddWidth = width.enumerated().filter { !$0.0.isMultiple(of: 2)}.map { $0.1 }.max()
      
      let totalHeight = subviews.map { $0.height }.reduce(0, +)
      return CGSize(width: (evenWidth ?? 0) + (oddWidth ?? 0), height: totalHeight)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
      guard !subviews.isEmpty else { return }
      let subviewSizes = subviews.map { $0.sizeThatFits(.unspecified) }
      let width = subviewSizes.map { $0.width }
      
      let evenWidth = width.enumerated().filter { $0.0.isMultiple(of: 2)}.map { $0.1 }.max()
      
      let evenX = bounds.minX
      let odddX = bounds.minX + (evenWidth ?? 0)
      
      var y = bounds.minY
      
      for (index, subview) in subviews.enumerated() {
        let subviewSize = subviewSizes[index]
        
        let proposedSize = ProposedViewSize(width: subviewSize.width,
                                            height: subviewSize.height)
        
        if index.isMultiple(of: 2) {
          subview.place(at: .init(x: evenX, y: y), anchor: .topLeading,
                        proposal: proposedSize)
        } else {
          subview.place(at: .init(x: odddX, y: y), anchor: .topLeading,
                        proposal: proposedSize)
        }
        
        y += subviewSize.height
      }
    }
  }
  

  public struct CustomVStack: Layout {

      private var columns: Int
      private var spacing: Double

      public init(columns: Int = 2, spacing: Double = 8.0) {
          self.columns = columns
          self.spacing = spacing
      }

      public func sizeThatFits(
          proposal: ProposedViewSize,
          subviews: Subviews,
          cache: inout ()
      ) -> CGSize {
          return calculateSize(for: subviews, in: proposal)
      }
      
      public func placeSubviews(
          in bounds: CGRect,
          proposal: ProposedViewSize,
          subviews: Subviews,
          cache: inout ()
      ) {
          calculateSize(for: subviews, in: proposal, placeInBounds: bounds)
      }

      @discardableResult
      private func calculateSize(
          for subviews: Subviews,
          in proposal: ProposedViewSize,
          placeInBounds bounds: CGRect? = nil
      ) -> CGSize {
          guard let maxWidth = proposal.width else { return .zero }
          let itemWidth = (maxWidth - spacing * Double(columns - 1)) / Double(columns)

          var xIndex: Int = 0
          var columnsHeights: [Double] = Array(repeating: bounds?.minY ?? 0, count: columns)

          subviews.forEach { view in
              let proposed = ProposedViewSize(
                  width: itemWidth,
                  height: view.sizeThatFits(.unspecified).height
              )

              if let bounds {
                  let x = (itemWidth + spacing) * Double(xIndex) + bounds.minX
                  view.place(
                      at: .init(x: x, y: columnsHeights[xIndex]),
                      anchor: .topLeading,
                      proposal: proposed
                  )
              }

              let height = view.dimensions(in: proposed).height
              columnsHeights[xIndex] += height + spacing
              let minimum = columnsHeights.enumerated().min {
                  $0.element < $1.element
              }?.offset ?? 0
              xIndex = minimum
          }

          guard let maxHeight = columnsHeights.max() else { return .zero }

          return .init(
              width: maxWidth,
              height: maxHeight - spacing

          )
      }

      public static var layoutProperties: LayoutProperties {
          var properties = LayoutProperties()
          properties.stackOrientation = .vertical
          return properties
      }

  }
  
  public struct CustomHStack: Layout {

      private var rows: Int
      private var spacing: Double

      init(rows: Int = 2, spacing: Double = 8.0) {
          self.rows = rows
          self.spacing = spacing
      }

      public func sizeThatFits(
          proposal: ProposedViewSize,
          subviews: Subviews,
          cache: inout ()
      ) -> CGSize {
          return calculateSize(for: subviews, in: proposal)
      }

      public func placeSubviews(
          in bounds: CGRect,
          proposal: ProposedViewSize,
          subviews: Subviews,
          cache: inout ()
      ) {
          calculateSize(for: subviews, in: proposal, placeInBounds: bounds)
      }

      @discardableResult
      private func calculateSize(
          for subviews: Subviews,
          in proposal: ProposedViewSize,
          placeInBounds bounds: CGRect? = nil
      ) -> CGSize {
          guard let maxHeight = proposal.height else { return .zero }
        
          let itemHeight = (maxHeight - spacing * Double(rows - 1)) / Double(rows)

          var yIndex: Int = 0
          var rowsWidths: [Double] = Array(repeating: bounds?.minX ?? 0, count: rows)

          subviews.forEach { view in
              let proposed = ProposedViewSize(
                  width: view.sizeThatFits(.unspecified).width,
                  height: itemHeight
              )

              if let bounds {
                  let y = (itemHeight + spacing) * Double(yIndex) + bounds.minY
                  view.place(
                      at: .init(x: rowsWidths[yIndex], y: y),
                      anchor: .topLeading,
                      proposal: proposed
                  )
              }

              let width = view.dimensions(in: proposed).width
              rowsWidths[yIndex] += width + spacing
              let minimum = rowsWidths.enumerated().min {
                  $0.element < $1.element
              }?.offset ?? 0
              yIndex = minimum
          }

          guard let maxWidth = rowsWidths.max() else { return .zero }

          return .init(
              width: maxWidth - spacing,
              height: maxHeight

          )
      }

      public static var layoutProperties: LayoutProperties {
          var properties = LayoutProperties()
          properties.stackOrientation = .horizontal
          return properties
      }

  }
}


struct CustomLayoutView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      CustomLayoutView()
    }
  }
}
