

import SwiftUI

struct KartCell: View {
    let kart: Kart

    var body: some View {
        VStack {
            if let image = loadImage(imageName: kart.imageName) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 161, height: 140)
                    .clipped()
                    .cornerRadius(8)
            }
            VStack() {
                Text(kart.name)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(Color(red: 244/255, green: 248/255, blue: 255/255))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                HStack() {
                    Text("Quantity")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color(red: 244/255, green: 248/255, blue: 255/255).opacity(0.7))
                    Spacer()
                    Text(" \(kart.quantity)")
                        .foregroundColor(.white)
                        .font(.system(size: 12, weight: .regular))
                }
                Spacer().frame(height: 8)
                HStack() {
                    Text("Maximum speed")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color(red: 244/255, green: 248/255, blue: 255/255).opacity(0.7))
                    Spacer()
                    Text(" \(kart.speed) km/h")
                        .foregroundColor(.white)
                        .font(.system(size: 12, weight: .regular))
                }
            }
            .padding(.horizontal, 6.0)
            .padding(.bottom, 12)

        }
        .padding([.top, .leading, .trailing], 6.0)
        .frame(height: 262)
        .background(Color(red: 24/255, green: 30/255, blue: 56/255))
        .cornerRadius(12)
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


