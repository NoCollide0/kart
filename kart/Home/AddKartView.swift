

import SwiftUI
import Combine

struct AddKartView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State private var showImagePicker = false
    @State private var image: UIImage?
    @State private var name: String = ""
    @State private var quantity: String = ""
    @State private var speed: String = ""
    var onDone: (UIImage?, String, Int, Int) -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("New go-kart")
                .font(.headline)
                .foregroundColor(.white)
            
            Button(action: {
                showImagePicker = true
            }) {
                if let image = image {
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
                        Image("kart_default1")
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
            
            CustomTextField(placeholder: "Enter name", text: $name)
            CustomTextField(placeholder: "Enter quantity", text: $quantity)
                .keyboardType(.numberPad)
            CustomTextField(placeholder: "Enter maximum speed", text: $speed)
                .keyboardType(.numberPad)
            
            Button(action: {
                if let quantityValue = Int(quantity), let speedValue = Int(speed) {
                    onDone(image, name, quantityValue, speedValue)
                    presentationMode.wrappedValue.dismiss()
                }
            }) {
                Text("Add")
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
            ImagePicker(image: $image)
        }
    }
    
    private var isButtonEnabled: Bool {
        image != nil && !name.isEmpty && !quantity.isEmpty && !speed.isEmpty
    }
}
