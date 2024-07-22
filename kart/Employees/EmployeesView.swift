

import SwiftUI

struct EmployeesView: View {
    
    @AppStorage("employees") private var employeesData: Data = Data()
    @State private var showAddEmployeeModal = false
    @State private var employees: [Employee] = []
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                VStack() {
                    Spacer().frame(height: 3)
                    Text("Employees")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(Color(red: 244/255, green: 248/255, blue: 255/255))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer().frame(height: 28)
                    if employees.isEmpty {
                        Spacer()
                        VStack {
                            Text("Add your employees")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(Color(red: 244/255, green: 248/255, blue: 255/255))
                            Spacer().frame(height: 4)
                            Text("Fill in the information")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(Color(red: 244/255, green: 248/255, blue: 255/255, opacity: 0.7))
                            Spacer().frame(height: 17)
                            Button(action: {
                                showAddEmployeeModal.toggle()
                            }) {
                                Text("Add employee")
                                    .font(.system(size: 15, weight: .regular))
                                    .frame(width: 125, height: 34)
                                    .background(Color(red: 60/255, green: 115/255, blue: 255/255))
                                    .foregroundColor(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 40))
                            }
                        }
                        .frame(width: 305, height: 162)
                        .background(Color(red: 255/255, green: 255/255, blue: 255/255, opacity: 0.05))
                        .cornerRadius(16)
                        Spacer().frame(height: 41)
                        Spacer()
                    } else {
                        ZStack() {
                            ScrollView() {
                                LazyVGrid(columns: [GridItem(.flexible(), spacing: 12), GridItem(.flexible())], spacing: 12) {
                                    ForEach(employees) { employee in
                                        EmployeeCell(employee: employee)
                                        
                                    }
                                }
                                .padding(.bottom, 7)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            VStack {
                                Spacer()
                                Button(action: {
                                    showAddEmployeeModal.toggle()
                                }) {
                                    Text("Add employee")
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
                .padding(.top, geometry.safeAreaInsets.top)
                .padding(.horizontal, 16)
                Divider()
                    .background(Color(red: 244/255, green: 248/255, blue: 255/255).opacity(0.12))
                    .padding(.bottom, geometry.safeAreaInsets.bottom)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 24/255, green: 30/255, blue: 56/255))
            .edgesIgnoringSafeArea(.all)
            .sheet(isPresented: $showAddEmployeeModal) {
                AddEmployeeView(onDone: { name, post, hours in
                    let newEmployee = Employee(name: name, post: post, hours: hours)
                    employees.append(newEmployee)
                    saveEmployees()
                })
            }
        }
        .onAppear {
            loadEmployees()
        }
    }
    private func saveEmployees() {
        if let encodedData = try? JSONEncoder().encode(employees) {
            employeesData = encodedData
        }
    }
    
    private func loadEmployees() {
        if let decodedEmployees = try? JSONDecoder().decode([Employee].self, from: employeesData) {
            employees = decodedEmployees
        }
    }
}




struct EmployeesView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeesView()
    }
}
