

import SwiftUI

struct Kart: Identifiable, Codable {
    var id = UUID()
    let imageName: String
    let name: String
    let quantity: Int
    let speed: Int
}
