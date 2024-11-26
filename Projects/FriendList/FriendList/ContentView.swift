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
    @State private var newImage: Image?

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
                            }
                            Text(friend.name)
                        }
                    }
                }
                Spacer()

                newImage?
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
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
                    await addNewFriend(newPicture: pickerItem)
                }
            }
        }
    }

    func addNewFriend(newPicture: PhotosPickerItem?) async {
        guard let imageData = try? await newPicture?.loadTransferable(type: Data.self) else {
            print("Failed to load image data")
            return
        }
        
        let friend = Friend(name: "New Friend", photo: imageData)
        modelContext.insert(friend)
    }

}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Friend.self, configurations: config)
        let context = container.mainContext
        
        // Convert placeholder image to Data
        guard let placeholderImage = UIImage(systemName: "person.circle.fill"),
              let imageData = placeholderImage.jpegData(compressionQuality: 0.8) else {
            return ContentView()
        }
        
        // Create and insert example friends
        let friend1 = Friend(name: "Maria", photo: imageData)
        let friend2 = Friend(name: "Parker", photo: imageData)
        let friend3 = Friend(name: "Danny", photo: imageData)
        
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
