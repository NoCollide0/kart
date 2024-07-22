

import SwiftUI

struct RepairView: View {

    @AppStorage("totalRepairValue") private var totalRepairValue: Int = 0
    @AppStorage("newRepairValue") private var newRepairValue: String = ""
    @AppStorage("repairItems") private var repairItemsData: Data = Data()
    
    @State private var showingCustomAlert = false
    @State private var showAddRepairModal = false
    @State private var repairItems: [Repair] = []
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    VStack {
                        HStack {
                            VStack(spacing: 10) {
                                Text("$\(totalRepairValue)")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(Color(red: 244/255, green: 248/255, blue: 255/255))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("Total cost of repairs")
                                    .font(.system(size: 15, weight: .regular))
                                    .foregroundColor(Color(red: 244/255, green: 248/255, blue: 255/255).opacity(0.3))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            Spacer()
                            
                            Button(action: {
                                showingCustomAlert = true
                            }) {
                                Image(systemName: "pencil")
                                    .resizable()
                                    .frame(width: 26, height: 26)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .frame(width: 32, height: 32)
                            
                            Spacer().frame(width: 22)
                        }
                        .padding(.horizontal, 10)
                        .frame(maxWidth: .infinity)
                        .frame(height: 114)
                        .background(Color(red: 19/255, green: 25/255, blue: 48/255))
                        .cornerRadius(12)
                        
                        Spacer().frame(height: 20)
                        
                        Text("Repair")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(Color(red: 244/255, green: 248/255, blue: 255/255))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer().frame(height: 10)
                        
                        ZStack {
                            if repairItems.isEmpty {
                                VStack {
                                    Spacer()
                                    VStack {
                                        Text("Add info Repair")
                                            .font(.system(size: 28, weight: .bold))
                                            .foregroundColor(Color(red: 244/255, green: 248/255, blue: 255/255))
                                        Spacer().frame(height: 4)
                                        Text("Fill out the repair expenses")
                                            .font(.system(size: 16, weight: .regular))
                                            .foregroundColor(Color(red: 244/255, green: 248/255, blue: 255/255, opacity: 0.7))
                                        Spacer().frame(height: 17)
                                        Button(action: {
                                            showAddRepairModal.toggle()
                                        }) {
                                            Text("Add info")
                                                .font(.system(size: 15, weight: .regular))
                                                .frame(width: 84, height: 34)
                                                .background(Color(red: 60/255, green: 115/255, blue: 255/255))
                                                .foregroundColor(.white)
                                                .clipShape(RoundedRectangle(cornerRadius: 40))
                                        }
                                    }
                                    .frame(width: 245, height: 162)
                                    .background(Color(red: 255/255, green: 255/255, blue: 255/255, opacity: 0.05))
                                    .cornerRadius(16)
                                    Spacer().frame(height: 157)
                                    Spacer()
                                }
                            } else {
                                ScrollView {
                                    VStack {
                                        ForEach(repairItems) { item in
                                            HStack {
                                                Text(item.name)
                                                    .font(.system(size: 16, weight: .regular))
                                                    .foregroundColor(Color(red: 244/255, green: 248/255, blue: 255/255, opacity: 0.7))
                                                Spacer()
                                                Text("$\(item.cost)")
                                                    .font(.system(size: 17, weight: .semibold))
                                                    .foregroundColor(Color(red: 244/255, green: 248/255, blue: 255/255))
                                            }
                                            .padding(.horizontal, 16)
                                            .frame(height: 60)
                                            if item.id != repairItems.last?.id {
                                                Divider()
                                                    .background(Color(red: 244/255, green: 248/255, blue: 255/255).opacity(0.12))
                                            }
                                        }
                                    }
                                    .padding(.vertical, 5)
                                    .background(Color(red: 255/255, green: 255/255, blue: 255/255).opacity(0.05))
                                    .cornerRadius(12)
                                    
                                    
                                }
                                VStack {
                                    Spacer()
                                    Button(action: {
                                        showAddRepairModal.toggle()
                                    }) {
                                        Text("Add info Repair")
                                            .font(.system(size: 17, weight: .regular))
                                            .frame(width: 286, height: 50)
                                            .background(Color(red: 60/255, green: 115/255, blue: 255/255))
                                            .foregroundColor(.white)
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                            .padding(16)
                                    }
                                }
                            }
                        }
                        
                        
                        

                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.top, geometry.safeAreaInsets.top + 20)
                    .padding(.horizontal, 16)
                    .padding(.bottom, -8)
                    .background(Color(red: 24/255, green: 30/255, blue: 56/255))
                    .edgesIgnoringSafeArea(.all)
                    
                    Divider()
                        .background(Color(red: 244/255, green: 248/255, blue: 255/255).opacity(0.12))
                        .padding(.bottom, geometry.safeAreaInsets.bottom)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(red: 24/255, green: 30/255, blue: 56/255))
                .edgesIgnoringSafeArea(.all)
                
                if showingCustomAlert {
                    CustomAlertView(
                        title: "Total cost of repairs",
                        message: nil,
                        textFieldPlaceholder: "Enter cost",
                        textFieldValue: $newRepairValue,
                        isPresented: $showingCustomAlert,
                        onAdd: {
                            if let value = Int(newRepairValue) {
                                totalRepairValue = value
                            }
                            newRepairValue = String(totalRepairValue)
                        }
                    )
                }

            }
            .sheet(isPresented: $showAddRepairModal) {
                AddRepairView(onDone: { name, cost in
                    let newRepair = Repair(name: name, cost: Int(cost)!)
                    repairItems.append(newRepair)
                    saveRepairItems()
                })
            }
        }
        .onAppear {
            loadRepairItems()
        }
    }
    private func saveRepairItems() {
        if let encodedData = try? JSONEncoder().encode(repairItems) {
            repairItemsData = encodedData
        }
    }
    
    private func loadRepairItems() {
        if let decodedRepairItems = try? JSONDecoder().decode([Repair].self, from: repairItemsData) {
            repairItems = decodedRepairItems
        }
    }
}

struct CustomAlertView: View {
    var title: String
    var message: String?
    var textFieldPlaceholder: String
    @Binding var textFieldValue: String
    @Binding var isPresented: Bool
    var onAdd: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack(spacing: 16) {
                    Text(title)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(Color.white)
                    
                    TextField(textFieldPlaceholder, text: $textFieldValue)
                        .keyboardType(.numberPad)
                        .padding(.horizontal, 6)
                        .frame(height: 26)
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color(red: 44/255, green: 44/255, blue: 46/255))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color(red: 84/255, green: 84/255, blue: 88/255).opacity(0.65), lineWidth: 0.5)
                                )
                        )
                        .onChange(of: textFieldValue) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                self.textFieldValue = filtered
                            }
                        }
                }
                .padding(.top, 19)
                .padding(.horizontal, 16)
                
                VStack {
                    Divider()
                        .background(Color(red: 29/255, green: 30/255, blue: 32/255))
                    Button(action: {
                        onAdd()
                        isPresented.toggle()
                    }) {
                        Text("Add")
                            .font(.system(size: 17, weight: .regular))
                        
                    }
                    .disabled(textFieldValue.isEmpty)
                }
                .padding(.bottom, 10)
                .frame(height: 44)
                .frame(maxWidth: .infinity)
            }
            .background(Color(red: 37/255, green: 37/255, blue: 37/255).opacity(0.9))
            .cornerRadius(14)
            .padding(.horizontal, 60)
        }
    }
}




struct RepairView_Previews: PreviewProvider {
    static var previews: some View {
        RepairView()
    }
}

