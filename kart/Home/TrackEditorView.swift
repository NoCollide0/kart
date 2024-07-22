

import SwiftUI
import Combine

struct TrackEditorView: View {
    @Binding var image: UIImage?
    @Binding var name: String
    @Binding var address: String
    @Environment(\.presentationMode) private var presentationMode
    @State private var showImagePicker = false
    @State private var tempImage: UIImage?
    @State private var tempName: String = ""
    @State private var tempAddress: String = ""
    var onDone: (UIImage?, String, String) -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Edit Basic Information")
                .font(.headline)
                .foregroundColor(.white)
            
            Button(action: {
                showImagePicker = true
            }) {
                if let image = tempImage {
                    ZStack {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 182, height: 150)
                            .clipped()
                            .cornerRadius(10)
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 25, height: 20)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.clear)
                    }
                } else {
                    ZStack {
                        Image("kart_default")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 182, height: 150)
                            .clipped()
                            .cornerRadius(10)
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 25, height: 20)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.clear)
                    }
                }
            }
            
            CustomTextField(placeholder: "Enter name", text: $tempName)
            CustomTextField(placeholder: "Enter address", text: $tempAddress)
            
            Button(action: {
                onDone(tempImage, tempName, tempAddress)
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save")
                    .padding()
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 16)
                    .background(isButtonEnabled ? Color(red: 60/255, green: 115/255, blue: 255/255) : Color(red: 255/255, green: 255/255, blue: 255/255, opacity: 0.12))
                    .foregroundColor(isButtonEnabled ? .white : Color(red: 244/255, green: 248/255, blue: 255/255, opacity: 0.3))
                    .cornerRadius(10)
                    .disabled(!isButtonEnabled)
            }
            .padding(.bottom, 20)
            
            Spacer()
        }
        .padding()
        .background(Color(red: 24/255, green: 30/255, blue: 56/255))
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $tempImage)
        }
    }
    
    private var isButtonEnabled: Bool {
        tempImage != nil && !tempName.isEmpty && !tempAddress.isEmpty
    }
}

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .font(.system(size: 15, weight: .regular, design: .default))
                    .foregroundColor(Color(red: 99/255, green: 99/255, blue: 101/255))
                    .padding(.leading, 15)
            }
            TextField("", text: $text)
                .padding(.leading, 15)
                .frame(height: 45)
                .background(Color.white.opacity(0.05))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(red: 244/255, green: 248/255, blue: 255/255).opacity(0.12), lineWidth: 1)
                )
                .font(.system(size: 15, weight: .regular, design: .default))
                .foregroundColor(.white)
        }
    }
}
