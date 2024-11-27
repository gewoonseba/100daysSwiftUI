//
//  NewFriendView.swift
//  FriendList
//
//  Created by Sebastian Stoelen on 26/11/2024.
//

import Foundation
import SwiftUI
import SwiftData

struct NewFriendView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @Binding var selectedImageData: Data?
    @State private var newFriendName = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                if let imageData = selectedImageData,
                   let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 300)
                }
                
                TextField("Friend's name", text: $newFriendName)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                Spacer()
            }
            .padding()
            .navigationTitle("New Friend")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if let imageData = selectedImageData {
                            let friend = Friend(name: newFriendName, photo: imageData, coordinate: nil)
                            modelContext.insert(friend)
                            dismiss()
                        }
                    }
                    .disabled(newFriendName.isEmpty || selectedImageData == nil)
                }
            }
        }
    }
}
