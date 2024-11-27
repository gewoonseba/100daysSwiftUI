//
//  ContentView.swift
//  FriendList
//
//  Created by Sebastian Stoelen on 26/11/2024.
//

import PhotosUI
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Friend.name) var friends: [Friend]

    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedImageData: Data?
    @State private var showingNewFriendSheet = false
    @State private var newFriendName = ""

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(friends) { friend in
                        HStack {
                            if let uiImage = UIImage(data: friend.photo) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 48, height: 48)
                                    .clipShape(Circle())
                                    .accessibilityHidden(true)
                            }
                            Text(friend.name)
                        }
                    }.onDelete { indexSet in
                        for index in indexSet {
                            modelContext.delete(friends[index])
                        }
                    }
                }
            }
            .navigationTitle("FriendList")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    PhotosPicker(selection: $pickerItem, matching: .images) {
                        Image(systemName: "person.crop.circle.badge.plus")
                    }
                }
            }
            .onChange(of: pickerItem) {
                Task {
                    if let data = try? await pickerItem?.loadTransferable(type: Data.self) {
                        selectedImageData = data
                        showingNewFriendSheet = true
                    }
                }
            }
            .sheet(isPresented: $showingNewFriendSheet) {
                NewFriendView(
                    selectedImageData: $selectedImageData
                )
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Friend.self, configurations: config)
        let context = container.mainContext

        // Convert placeholder image to Data
        guard let placeholderImage = UIImage(systemName: "person.circle.fill"),
              let imageData = placeholderImage.jpegData(compressionQuality: 0.8)
        else {
            return ContentView()
        }

        // Create and insert example friends
        let friend1 = Friend(name: "Maria", photo: imageData, coordinate: nil)
        let friend2 = Friend(name: "Parker", photo: imageData, coordinate: nil)
        let friend3 = Friend(name: "Danny", photo: imageData, coordinate: nil)

        context.insert(friend1)
        context.insert(friend2)
        context.insert(friend3)

        return ContentView()
            .modelContainer(container)
    } catch {
        print("Error: \(error)")
        return ContentView()
    }
}
