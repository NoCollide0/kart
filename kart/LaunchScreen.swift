

import SwiftUI

struct LaunchScreen: View {
    
    var body: some View {
        ZStack{
            Color.black

                VStack(spacing: 257) {
                    
                    Image("LoadingScreenLogo")
                        .resizable()
                        .frame(width: 340, height: 181)
                    
                    
                    ActivityIndicator()
                }


        }
        .ignoresSafeArea(.all)
    }
}

struct ActivityIndicator: UIViewRepresentable {
    typealias UIViewType = UIActivityIndicatorView

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        return activityIndicator
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        uiView.startAnimating()
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
