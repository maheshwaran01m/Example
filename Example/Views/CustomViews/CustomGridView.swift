//
//  CustomGridView.swift
//  Example
//
//  Created by MAHESHWARAN on 20/10/23.
//

import SwiftUI

struct CustomGridView: View {
  
  @State private var records = (0...15).map { Item(title: "Value \($0)") }
  
  var body: some View {
    TagLayout(spacing: 4) {
      ForEach(records.indices, id: \.self) { index in
        chipView(for: index)
      }
    }
  }
  
  func chipView(for index: Int) -> some View {
    Text(records[index].title)
      .padding(10)
      .background(records[index].color.opacity(0.3))
      .clipShape(Capsule())
    
      .onTapGesture {
        if records[index].title == "Example Value \(index)" {
          records[index].title = "Value \(index)"
          records[index].color = .blue
        } else {
          records[index].title = "Example Value \(index)"
          records[index].color = .pink
        }
      }
  }
}

#Preview {
  CustomGridView()
}

extension CustomGridView {
  
  struct Item: Identifiable {
    var id = UUID().uuidString
    var title: String
    var color: Color = .blue
  }
  
  struct TagLayout: Layout {
    
    var alignment = Alignment.center
    var spacing: CGFloat = 4
    
    func sizeThatFits(proposal: ProposedViewSize,
                      subviews: Subviews,
                      cache: inout ()) -> CGSize {
      
      let maxWidth = proposal.width ?? 0
      let rows = generateRows(
        maxWidth,
        proposal: proposal,
        subviews: subviews)
      
      var height = CGFloat.zero
      
      for (index, row) in rows.enumerated() {
        let rowHeight = row.compactMap { $0.sizeThatFits(proposal).height }.max() ?? 0
        
        if index == (rows.count - 1) {
          height += rowHeight
        } else {
          height += rowHeight + spacing
        }
      }
      
      return .init(width: maxWidth, height: height)
    }
    
    func placeSubviews(in bounds: CGRect,
                       proposal: ProposedViewSize,
                       subviews: Subviews, cache: inout ()) {
      var origin = bounds.origin
      let maxWidth = bounds.width
      let rows = generateRows(
        maxWidth,
        proposal: proposal,
        subviews: subviews)
      
      for row in rows {
        let leading = bounds.maxX - maxWidth
        
        let trailing = bounds.maxX - (row.reduce(CGFloat.zero) {
          let width = $1.sizeThatFits(proposal).width
          
          return $0 + width + ($1 == row.last ? spacing : 0)
        })
        
        let center = (leading + trailing) / 2
        origin.x = (alignment == .leading ? leading : alignment == .trailing ? trailing : center)
        for view in row {
          let size = view.sizeThatFits(proposal)
          view.place(at: origin, proposal: proposal)
          
          origin.x += size.width + spacing
        }
        let rowHeight = row.compactMap { $0.sizeThatFits(proposal).height }.max() ?? 0
        
        origin.y += rowHeight + spacing
      }
    }
    
    func generateRows(_ maxWidth: CGFloat,
                      proposal: ProposedViewSize,
                      subviews: Subviews) -> [[LayoutSubviews.Element]] {
      
      var currentRow: [LayoutSubviews.Element] = []
      var rows: [[LayoutSubviews.Element]] = []
      
      var origin = CGRect.zero.origin
      
      for view in subviews {
        let size = view.sizeThatFits(proposal)
        
        if (origin.x + size.width + spacing) > maxWidth {
          rows.append(currentRow)
          currentRow.removeAll()
          origin.x = 0
          
          currentRow.append(view)
          origin.x += size.width + spacing
        } else {
          currentRow.append(view)
          origin.x += size.width + spacing
        }
      }
      if !currentRow.isEmpty {
        rows.append(currentRow)
        currentRow.removeAll()
      }
      return rows
    }
  }
}
