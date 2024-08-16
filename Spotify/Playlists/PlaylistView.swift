import SwiftUI
import FirebaseStorage

struct PlaylistView: View {
    let userName: String
    let imageURL: String
    @State private var image: UIImage?
    
    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
            } else {
                ProgressView()
            }
            Text(userName)
                .font(.title)
        }
        .onAppear {
            fetchImageFromFirebase()
        }
    }
    
    private func fetchImageFromFirebase() {
        let storage = Storage.storage()
        let reference = storage.reference(forURL: imageURL)
        
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
    PlaylistView(userName: "Sezen Aksu", imageURL: "gs://your-firebase-storage-url/sezen_aksu.jpg")
}
