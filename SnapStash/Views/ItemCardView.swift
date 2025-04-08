//
//  ItemCardView.swift
//  SnapStash
//
//  Created by Work on 4/8/25.
//

import SwiftUI

struct ItemCardView: View {
    let item: ItemModel
    
    var body: some View {
        HStack {
            Image(uiImage: item.image)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(radius: 2)
            
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text("📍 \(item.location)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .shadow(radius: 4)
    }
}
