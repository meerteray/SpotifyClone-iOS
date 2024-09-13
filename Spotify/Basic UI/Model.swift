import Foundation
import SwiftUI
import FirebaseFirestore

struct User: Identifiable {
    var id: String
    var name: String
    var imageURL: String
    var songs: [Song] = []
}

struct Song: Identifiable {
    var id: String
    var name: String
    var song: String
}
