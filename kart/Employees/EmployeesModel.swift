

import SwiftUI

struct Employee: Identifiable, Codable {
    var id = UUID()
    let name: String
    let post: String
    let hours: String
}
