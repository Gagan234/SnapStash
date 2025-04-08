//
//  HomeView.swift
//  SnapStash
//
//  Created by Work on 4/8/25.
//

import SwiftUI

struct HomeView: View {
    @State private var showImagePicker = false
    @State private var showItemInput = false
    @State private var selectedImage: UIImage?
    @State private var searchText = ""

    @State private var imageSource: UIImagePickerController.SourceType = .camera
    @State private var showPhotoOptions = false

    @StateObject private var itemStore = ItemStore()

    var body: some View {
        NavigationStack {
            VStack {
                if itemStore.filteredItems(searchText).isEmpty {
                    Text("No items yet. Tap the 📸 below!")
                        .foregroundColor(.secondary)
                        .padding(.top, 100)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(itemStore.filteredItems(searchText)) { item in
                                ItemCardView(item: item)
                                    .padding(.horizontal)
                            }
                        }
                        .padding(.top)
                    }
                }
            }
            .navigationTitle("SnapStash")
            .searchable(text: $searchText, prompt: "Find your stuff...")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        showPhotoOptions = true
                    }) {
                        Image(systemName: "camera")
                            .font(.title)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }
                }
            }
            .confirmationDialog("Add Photo", isPresented: $showPhotoOptions) {
                Button("Take Photo") {
                    imageSource = .camera
                    showImagePicker = true
                }
                Button("Choose from Library") {
                    imageSource = .photoLibrary
                    showImagePicker = true
                }
                Button("Cancel", role: .cancel) {}
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $selectedImage, sourceType: imageSource)
                    .onDisappear {
                        if selectedImage != nil {
                            showItemInput = true
                        }
                    }
            }
            .sheet(isPresented: $showItemInput) {
                ItemInputModalView(image: selectedImage!, onSave: { name, location in
                    itemStore.addItem(name: name, location: location, image: selectedImage!)
                    selectedImage = nil
                })
            }
        }
    }
}

#Preview {
    HomeView()
}

