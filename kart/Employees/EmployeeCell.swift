

import SwiftUI

struct EmployeeCell: View {
    let employee: Employee
    
    var body: some View {
        VStack() {
            Text("\(employee.name)")
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(Color(red: 244/255, green: 248/255, blue: 255/255))
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("\(employee.post)")
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(Color(red: 244/255, green: 248/255, blue: 255/255).opacity(0.7))
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer().frame(height: 16)
            Text("\(employee.hours)")
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(Color(red: 244/255, green: 248/255, blue: 255/255))
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Working hours")
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(Color(red: 244/255, green: 248/255, blue: 255/255).opacity(0.3))
                .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 17)
        .frame(height: 116)
        .background(Color(red: 255/255, green: 255/255, blue: 255/255).opacity(0.05))
        .cornerRadius(12)
    }
}

struct EmployeeCell_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeCell(employee: Employee(name: "Tom", post: "Driver", hours: "10:00-11:00"))
            
    }
}

