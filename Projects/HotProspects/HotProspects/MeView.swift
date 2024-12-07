//
//  MeView.swift
//  HotProspects
//
//  Created by Sebastian Stoelen on 03/12/2024.
//

import CoreImage.CIFilterBuiltins
import SwiftUI

struct MeView: View {
    @AppStorage("name") private var name = "Anonymous"
    @AppStorage("emailAddress") private var emailAddress = "you@yoursite.com"
    
    @State private var qrCode = UIImage()

    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $name)
                        .textContentType(.name)
                        .font(.title)

                    TextField("Email address", text: $emailAddress)
                        .textContentType(.emailAddress)
                        .font(.title)
                }

                Section {
                    HStack {
                        Spacer()
                        Image(uiImage: qrCode)
                            .interpolation(.none)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .padding()
                            .contextMenu {
                                ShareLink(
                                    item: Image(uiImage: qrCode), preview: SharePreview("My QR code", image: Image(uiImage: qrCode)))
                            }
                        Spacer()
                    }
                }
            }
            .navigationTitle("Your code")
            .onAppear(perform: updateCode)
            .onChange(of: name, updateCode)
            .onChange(of: emailAddress, updateCode)
        }
    }
    
    func updateCode() {
        qrCode = generateQRCode(from: "\(name) \n\(emailAddress)")
    }

    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)

        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
                
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

#Preview {
    MeView()
}
