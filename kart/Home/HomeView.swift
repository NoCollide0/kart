

import SwiftUI
import Combine

struct HomeView: View {
    
    @AppStorage("karts") private var kartsData: Data = Data()
    @AppStorage("trackImageName") private var trackImageName: String?
    @AppStorage("trackName") private var trackName: String = ""
    @AppStorage("trackAddress") private var trackAddress: String = ""
    
    @State private var showImagePicker = false
    @State private var image: UIImage? = nil
    @State private var name: String = ""
    @State private var address: String = ""
    @State private var showTrackEditorModal = false
    @State private var showAddKartModal = false
    @State private var karts: [Kart] = []
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .top) {
                    Button(action: {
                        showTrackEditorModal.toggle()
                    }) {
                        if let image = image {
                            VStack {
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 390,height: 320)
                                    .clipped()
                                    .overlay(
                                        LinearGradient(
                                            gradient: Gradient(colors: [
                                                Color.clear,
                                                Color(red: 14/255, green: 19/255, blue: 36/255)
                                            ]),
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    )
                                    .overlay(
                                        VStack(alignment: .leading) {
                                            Text(name)
                                                .font(.system(size: 28, weight: .bold))
                                                .lineSpacing(34 - 28)
                                                .foregroundColor(Color(red: 244/255, green: 248/255, blue: 255/255))
                                            Spacer().frame(height: 4)
                                            Text(address)
                                                .font(.system(size: 16, weight: .regular))
                                                .lineSpacing(21 - 16)
                                                .foregroundColor(Color(red: 244/255, green: 248/255, blue: 255/255, opacity: 0.7))
                                        }
                                            .padding(.leading, 16)
                                            .padding(.bottom, 58)
                                            .frame(maxWidth: .infinity, alignment: .leading),
                                        alignment: .bottomLeading
                                    )
                                    .edgesIgnoringSafeArea(.top)
                                Spacer()
                            }
                            
                            
                        } else {
                            VStack {
                                Spacer()
                                VStack {
                                    Text("Add the data")
                                        .font(.system(size: 28, weight: .bold))
                                        .lineSpacing(34 - 28)
                                        .foregroundColor(Color(red: 244/255, green: 248/255, blue: 255/255))
                                    Spacer().frame(height: 4)
                                    Text("Indicate basic information")
                                        .font(.system(size: 16, weight: .regular))
                                        .lineSpacing(21 - 16)
                                        .foregroundColor(Color(red: 244/255, green: 248/255, blue: 255/255, opacity: 0.7))
                                    Spacer().frame(height: 17)
                                    Text("Add information")
                                        .font(.system(size: 15, weight: .regular))
                                        .lineSpacing(20 - 15)
                                        .frame(width: 136, height: 34)
                                        .background(Color(red: 60/255, green: 115/255, blue: 255/255))
                                        .foregroundColor(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 40))
                                }
                                .frame(width: 270.0, height: 167.0)
                                .background(Color(red: 0.14, green: 0.162, blue: 0.26))
                                .cornerRadius(16)
                                .padding(.top, geometry.safeAreaInsets.top)
                                Spacer()
                            }
                            .frame(height: 270)
                        }
                        
                    }
                    
                    
                    VStack {
                        VStack(spacing: 12) {
                            RoundedRectangle(cornerRadius: 19)
                                .fill(Color(red: 244/255, green: 248/255, blue: 255/255).opacity(0.12))
                                .frame(width: 40, height: 5)
                                .padding(.top, 16)
                            
                            Text("My go-karts")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(Color(red: 244/255, green: 248/255, blue: 255/255))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            if karts.isEmpty {
                                VStack {
                                    Text("Add go-karts")
                                        .font(.system(size: 28, weight: .bold))
                                        .foregroundColor(Color(red: 244/255, green: 248/255, blue: 255/255))
                                    Spacer().frame(height: 4)
                                    Text("Manage your fleets")
                                        .font(.system(size: 16, weight: .regular))
                                        .foregroundColor(Color(red: 244/255, green: 248/255, blue: 255/255, opacity: 0.7))
                                    Spacer().frame(height: 17)
                                    Button(action: {
                                        showAddKartModal.toggle()
                                    }) {
                                        Text("Add a go-kart")
                                            .font(.system(size: 15, weight: .regular))
                                            .frame(width: 121, height: 34)
                                            .background(Color(red: 60/255, green: 115/255, blue: 255/255))
                                            .foregroundColor(.white)
                                            .clipShape(RoundedRectangle(cornerRadius: 40))
                                    }
                                    
                                }
                                .padding(.bottom, 93)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color(red: 19/255, green: 25/255, blue: 48/255))
                            } else {
                                ZStack {
                                    ScrollView {
                                        LazyVGrid(columns: [GridItem(.flexible(), spacing: 8), GridItem(.flexible())], spacing: 8) {
                                            ForEach(karts) { kart in
                                                KartCell(kart: kart)
                                            }
                                        }
                                        //.padding(.bottom, 300)
                                        .padding(.bottom, geometry.safeAreaInsets.bottom)
                                        
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(Color(red: 19/255, green: 25/255, blue: 48/255))
                                    
                                    
                                    VStack {
                                        Spacer()
                                        Button(action: {
                                            showAddKartModal.toggle()
                                        }) {
                                            Text("Add a go-kart")
                                                .font(.system(size: 17, weight: .regular))
                                                .frame(width: 286, height: 50)
                                                .background(Color(red: 60/255, green: 115/255, blue: 255/255))
                                                .foregroundColor(.white)
                                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                                .padding()
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 16.0)
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 19/255, green: 25/255, blue: 48/255))
                        .clipShape(RoundedCorner(corners: [.topLeft, .topRight], radius: 20))
                        .edgesIgnoringSafeArea(.bottom)
                        
                    }
                    .padding(.top, 280)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                    
                    
                    
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.bottom, -8)
                
                
                
                Divider()
                    .background(Color(red: 244/255, green: 248/255, blue: 255/255).opacity(0.12))
                    .padding(.bottom, geometry.safeAreaInsets.bottom)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 24/255, green: 30/255, blue: 56/255))
            .edgesIgnoringSafeArea(.all)
            .sheet(isPresented: $showTrackEditorModal) {
                TrackEditorView(image: $image, name: $name, address: $address,
                    onDone: { pickedImage, pickedName, pickedAddress in
                        if let pickedImage = pickedImage {
                            image = pickedImage
                            trackImageName = saveImage(image: pickedImage)
                        }
                        trackName = pickedName
                        trackAddress = pickedAddress
                    }
                )
            }
            .sheet(isPresented: $showAddKartModal) {
                AddKartView(onDone: { image, name, quantity, speed in
                    if let image = image {
                        let imageName = saveImage(image: image)
                        let newKart = Kart(imageName: imageName, name: name, quantity: quantity, speed: speed)
                        karts.append(newKart)
                        saveKarts()
                    }
                })
            }
            .onAppear {
                loadKarts()
                loadTrack()
            }
        }
        
    }
    private func saveKarts() {
        if let data = try? JSONEncoder().encode(karts) {
            kartsData = data
        }
    }
    
    private func loadKarts() {
        if let decoded = try? JSONDecoder().decode([Kart].self, from: kartsData) {
            karts = decoded
        }
    }
    
    private func loadTrack() {
        if let trackImageName = trackImageName {
            image = loadImage(imageName: trackImageName)
        }
        name = trackName
        address = trackAddress
    }
    
    private func saveImage(image: UIImage) -> String {
        let imageName = UUID().uuidString
        if let data = image.jpegData(compressionQuality: 0.8) {
            let url = getDocumentsDirectory().appendingPathComponent(imageName)
            try? data.write(to: url)
        }
        return imageName
    }
    
    private func loadImage(imageName: String) -> UIImage? {
        let url = getDocumentsDirectory().appendingPathComponent(imageName)
        if let data = try? Data(contentsOf: url) {
            return UIImage(data: data)
        }
        return nil
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}




struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}




struct RoundedCorner: Shape {
    var corners: UIRectCorner
    var radius: CGFloat

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}



