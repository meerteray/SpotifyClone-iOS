import SwiftUI
import FirebaseStorage

struct PlaylistView: View {
    let selectedUser: User
    @State private var image: UIImage?
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        VStack {
                            if let image = image {
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 200, height: 200)
                            } else {
                                ProgressView()
                            }
                            Text(selectedUser.name)
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                    ForEach(selectedUser.songs) { song in
                        Text(song.name)
                            .foregroundColor(.white)
                            .padding(.vertical, 4)
                    }
                }
                .padding()
            }
        }
        .onAppear {
            fetchImageFromFirebase()
        }
    }
    
    private func fetchImageFromFirebase() {
        let storage = Storage.storage()
        let reference = storage.reference(forURL: selectedUser.imageURL)
        
        reference.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
            } else if let data = data, let uiImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = uiImage
                }
            }
        }
    }
}

#Preview {
    PlaylistView(
        selectedUser:
            User(id: "1", name: "Sezen Aksu", imageURL:"https://firebasestorage.googleapis.com/v0/b/spotifyclone-80fcd.appspot.com/o/sezenAksuImage.jpg?alt=media&token=4051d5d1-1c0c-4412-9e7d-c142f29f5cef",
                 songs: [
                    Song(id: "1", name: "Gülümse", song: ""),
                    Song(id: "2", name: "Firuze", song: ""),
                    Song(id: "3", name: "Kaybolan Yıllar", song: "")
                 ])
    )
}
