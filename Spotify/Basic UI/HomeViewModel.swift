import SwiftUI
import FirebaseFirestore

class HomeViewModel: ObservableObject {
    @Published var userName: String = ""

    func fetchUserName() {
        let db = Firestore.firestore()
        let userId = "123"

        db.collection("users").document(userId).getDocument { document, error in
            if let document = document, document.exists {
                let data = document.data()
                self.userName = data?["name"] as? String ?? "İsim bulunamadı"
            } else {
                print("Belge bulunamadı: \(String(describing: error))")
            }
        }
    }
}

