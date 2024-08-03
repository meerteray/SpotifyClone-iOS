import SwiftUI
import FirebaseFirestore

struct HomeView: View {
    @State private var userName: String = ""

    var body: some View {
        VStack {
            Text("Kullanıcı Adı: \(userName)")
                .padding()
            Button(action: {
                fetchUserName()
            }) {
                Text("Kullanıcı Adını Çek")
            }
        }
    }

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


#Preview {
    HomeView()
}
