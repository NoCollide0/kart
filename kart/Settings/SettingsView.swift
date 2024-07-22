

import SwiftUI
import StoreKit

struct SettingsView: View {
    
    @State private var isShareSheetShowing = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {
                    Spacer().frame(height: 3)
                    Text("Settings")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(Color(red: 244/255, green: 248/255, blue: 255/255))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack {
                        Button(action: {
                            if #available(iOS 14.0, *) {
                                if let scene = UIApplication.shared.windows.first?.windowScene {
                                    SKStoreReviewController.requestReview(in: scene)
                                }
                            } else {
                                SKStoreReviewController.requestReview()
                            }
                        }) {
                            VStack {
                                Image(systemName: "star.leadinghalf.filled")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.white)
                                Text("Rate app")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                            .frame(width: 170, height: 100)
                            .background(Color(red: 255/255, green: 255/255, blue: 255/255).opacity(0.05))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        Spacer()
                        Button(action: {
                            //isShareSheetShowing.toggle()
                        }) {
                            VStack {
                                Image(systemName: "square.and.arrow.up")
                                    .resizable()
                                    .frame(width: 25, height: 30)
                                    .foregroundColor(.white)
                                Text("Share app")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                            .frame(width: 170, height: 100)
                            .background(Color(red: 255/255, green: 255/255, blue: 255/255).opacity(0.05))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    .sheet(isPresented: $isShareSheetShowing, content: {
                        ShareSheet(activityItems: ["Check out this great app! [App Link]"])
                    })
                    
                    Spacer().frame(height: 20)
                    
                    Button(action: {
                        
                    }) {
                        VStack {
                            Image(systemName: "doc.text")
                                .resizable()
                                .frame(width: 25, height: 30)
                                .foregroundColor(.white)
                            Text("Usage Policy")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(.white)
                        }
                        .frame(width: 360, height: 100)
                        .background(Color(red: 255/255, green: 255/255, blue: 255/255).opacity(0.05))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }

                    Spacer()
                }
                .padding(.top, geometry.safeAreaInsets.top)
                .padding(.horizontal, 16)
                
                Divider()
                    .background(Color(red: 244/255, green: 248/255, blue: 255/255).opacity(0.12))
                    .padding(.bottom, geometry.safeAreaInsets.bottom)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 19/255, green: 25/255, blue: 48/255))
            .edgesIgnoringSafeArea(.all)
        }
    }

}

struct ShareSheet: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        return UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
