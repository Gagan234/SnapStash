//
//  ItemInputModalView.swift
//  SnapStash
//
//  Created by Work on 4/8/25.
//

import SwiftUI

struct ItemInputModalView: View {
    var image: UIImage
    var onSave: (String, String) -> Void
    
    @Environment(\.dismiss) private var dismiss
    @State private var name = ""
    @State private var location = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(12)
                    .shadow(radius: 4)
                
                TextField("Item Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Location", text: $location)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Save") {
                    onSave(name, location)
                    dismiss()
                }
                .disabled(name.isEmpty || location.isEmpty)
                .buttonStyle(.borderedProminent)
                .padding(.top)

                Spacer()
            }
            .padding()
            .navigationTitle("Item Details")
        }
    }
}
