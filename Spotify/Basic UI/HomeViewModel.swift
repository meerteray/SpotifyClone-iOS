import Foundation
import SwiftUI
import FirebaseFirestore

class HomeViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var selectedUser: User?
    private var db = Firestore.firestore()
    
    func fetchUsers() {
        self.db.collection("users").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Veri çekilirken hata oluştu: \(error)")
                return
            }
            
            let documents = querySnapshot?.documents ?? []
            let group = DispatchGroup()
            
            for document in documents {
                let data = document.data()
                let id = document.documentID
                let name = data["name"] as? String ?? ""
                let imageURL = data["imageURL"] as? String ?? ""
                var user = User(id: id, name: name, imageURL: imageURL)
                
                group.enter()
                self.fetchSongsForUser(userId: id) { songs in
                    user.songs = songs
                    
                    self.fetchLikedSongs(userId: id) { likes in
                        user.likes = likes
                        self.users.append(user)
                    }
                    group.leave()
                }
            }
            
            group.notify(queue: .main) {
                print("Tüm kullanıcılar ve şarkıları yüklendi.")
            }
        }
    }
    
    private func fetchSongsForUser(userId: String, completion: @escaping ([Song]) -> Void) {
        self.db.collection("users").document(userId).collection("songs").getDocuments { (songSnapshot, error) in
            if let error = error {
                print("Şarkılar çekilirken hata oluştu: \(error)")
                completion([])
                return
            }
            
            let songs = songSnapshot?.documents.compactMap { songDocument -> Song? in
                let data = songDocument.data()
                let id = songDocument.documentID
                if let name = data["name"] as? String {
                    let song = data["song"] as? String  ?? ""
                    //print("Şarkı ismi: \(name) 1905 \(song)")

                    return Song(id: id, name: name, song: song)

                }
                return nil
            } ?? []
            
            completion(songs)
        }
    }
    
    private func fetchLikedSongs(userId: String, completion: @escaping ([Song]) -> Void) {
        self.db.collection("users").document("000").collection("likedSongs").getDocuments { (songSnapshot, error) in
            if let error = error {
                print("Beğenilen şarkılar çekilirken hata oluştu: \(error)")
                completion([])
                return
            }
            
            let likedSongs = songSnapshot?.documents.compactMap { songDocument -> Song? in
                let data = songDocument.data()
                let id = songDocument.documentID
                if let name = data["name"] as? String {
                    let song = data["song"] as? String  ?? ""
                    //print("Beğenilen Şarkı ismi: \(name) 1905 \(song)")

                    return Song(id: id, name: name, song: song)
                }
                return nil
            } ?? []
            
            completion(likedSongs)
        }
    }
  
    func selectUser(_ user: User) {
        self.selectedUser = user
    }
}
