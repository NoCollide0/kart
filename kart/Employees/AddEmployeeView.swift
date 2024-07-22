

import SwiftUI

struct AddEmployeeView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State private var name: String = ""
    @State private var post: String = ""
    @State private var hours: String = ""
    var onDone: (String, String, String) -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("New employee")
                .font(.headline)
                .foregroundColor(.white)
            
            CustomTextField(placeholder: "Enter name", text: $name)
            CustomTextField(placeholder: "Enter post", text: $post)
            CustomTextField(placeholder: "Enter working hours", text: $hours)
            
            Button(action: {
                    onDone(name, post, hours)
                    presentationMode.wrappedValue.dismiss()
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

        
    }
    
    
    private var isButtonEnabled: Bool {
        !name.isEmpty && !post.isEmpty && !hours.isEmpty
    }
}
