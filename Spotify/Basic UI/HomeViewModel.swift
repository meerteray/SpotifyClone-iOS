import Foundation
import SwiftUI
import FirebaseFirestore

class HomeViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var selectedUser: User?


    func fetchUsers() {
        let db = Firestore.firestore()
        
        db.collection("users").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Veri çekilirken hata oluştu: \(error)")
                return
            }
            
            self.users = querySnapshot?.documents.compactMap { document -> User? in
                let data = document.data()
                let id = document.documentID
                let  name = data["name"] as! String
                let  imageURL = data["imageURL"] as? String ?? ""

                    return User(id: id, name: name, imageURL: imageURL)

              
            } ?? []
        }
    }

    func selectUser(_ user: User) {
        self.selectedUser = user
    }
}
