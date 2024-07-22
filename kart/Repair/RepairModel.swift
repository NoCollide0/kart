

import SwiftUI

struct Repair: Identifiable, Codable {
    var id = UUID()
    let name: String
    let cost: Int
}
