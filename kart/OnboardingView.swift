

import SwiftUI
import StoreKit

struct OnboardingView: View {
    @State private var currentPage = 0
    @AppStorage("firstEnter") private var firstEnter = true
    @State private var finishedOnboarding = false
    
    var images = ["onb1", "onb2", "onb3"]
    var texts = ["Your go-kart fleet", "Employees are under control", "Write down the repair costs"]
    var smallTexts = ["All go-kart cars in one place", "Make important changes quickly", "Control all expenses in the app"]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                NavigationView {
                    
                    ZStack {
                        
                        TabView(selection: $currentPage) {
                            ForEach(0..<images.count, id: \.self) { index in
                                ZStack {
                                    Image(images[index])
                                        .resizable()
                                        .tag(index)
                                        .aspectRatio(contentMode: .fill)
                                        .clipped()
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .ignoresSafeArea(.all)
                                    VStack(alignment: .leading) {
                                        Spacer()
                                        
                                        Text(texts[currentPage])
                                            .font(.system(size: 28, weight: .bold))
                                            .foregroundColor(Color(red: 244/255, green: 248/255, blue: 255/255))
                                        Spacer().frame(height: 5)
                                        Text(smallTexts[currentPage])
                                            .font(.system(size: 17, weight: .regular))
                                            .foregroundColor(Color(red: 244/255, green: 248/255, blue: 255/255).opacity(0.4))
                                        
                                        
                                        
                                        HStack{
                                            PageControl(numberOfPages: images.count, currentPage: $currentPage)
                                            Spacer()
                                            Button(action: {
                                                if currentPage < images.count - 1 {
                                                    withAnimation {
                                                        currentPage += 1
                                                    }
                                                } else {
                                                    firstEnter = false
                                                    finishedOnboarding = true
                                                }
                                            }) {
                                                Text("Next")
                                                    .font(.title)
                                                    .frame(width: 160, height: 45)
                                                    .background(Color.blue)
                                                    .foregroundColor(.white)
                                                    .cornerRadius(18)
                                            }
                                        }
                                        .padding(.bottom, geometry.safeAreaInsets.bottom + 35)
                                        
                                        
                                    }
                                    .padding(.horizontal, 15)
                                }
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                        
                        NavigationLink(
                            destination: AnyView(ContentView().navigationBarBackButtonHidden(true)),
                            isActive: $finishedOnboarding
                        ) {
                            EmptyView()
                        }
                        
                    }
                    .ignoresSafeArea(.all)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black)
                    
                }
                .navigationBarHidden(true)
                .ignoresSafeArea(.all)
                
            }
            

        }

    }
    func requestReview() {
        if #available(iOS 14.0, *) {
            if let scene = UIApplication.shared.windows.first?.windowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        } else {
            SKStoreReviewController.requestReview()
        }
    }
}

struct PageControl: View {
    var numberOfPages: Int
    @Binding var currentPage: Int

    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<numberOfPages, id: \.self) { page in
                if page == currentPage {
                    RoundedRectangle(cornerRadius: 50)
                        .frame(width: 25, height: 8)
                        .foregroundColor(.blue)
                } else {
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
