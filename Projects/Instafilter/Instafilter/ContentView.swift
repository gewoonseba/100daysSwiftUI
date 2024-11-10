//
//  ContentView.swift
//  Instafilter
//
//  Created by Sebastian Stoelen on 07/11/2024.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import SwiftUI

struct ContentView: View {
    @State private var selectedItem: PhotosPickerItem?
    @State private var processedImage: Image?
    @State private var filterIntensity: Double = 0.5
    
    @State private var currentFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                PhotosPicker(selection: $selectedItem) {
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("Tap to import a picture"))
                    }
                }
                .buttonStyle(.plain)
                .onChange(of: selectedItem, loadImage)
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity, applyProcessing)
                }.padding(.vertical)
                
                HStack {
                    Button(action: changeFilter) {
                        Text("Change filter")
                            .frame(maxWidth: .infinity)
                            .padding(6)
                    }
                    .buttonStyle(.bordered)
                    .foregroundStyle(.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
        
                    Button(action: shareImage) {
                        Text("Share")
                            .frame(maxWidth: .infinity)
                            .padding(6)
                    }
                    .buttonStyle(.bordered)
                    .foregroundStyle(.primary)
                }
                
                Spacer()
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
        }
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData)?.fixedOrientation() else { return }
            
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
    }
    
    func applyProcessing() {
        currentFilter.intensity = Float(filterIntensity)

        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }

        let uiImage = UIImage(cgImage: cgImage).fixedOrientation()
        processedImage = Image(uiImage: uiImage)
    }
    
    func changeFilter() {}
    
    func shareImage() {}
}

//Fix image being rotated after applying effects
extension UIImage {
    func fixedOrientation() -> UIImage {
        if imageOrientation == .up {
            return self
        }

        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: CGRect(origin: .zero, size: size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return normalizedImage
    }
}

#Preview {
    ContentView()
}
