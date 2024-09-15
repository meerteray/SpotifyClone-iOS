import SwiftUI
import FirebaseStorage
import AVFoundation

struct PlaylistView: View {
    @StateObject private var viewModel: PlaylistViewModel
    let selectedUser: User
    
    init(selectedUser: User) {
        self.selectedUser = selectedUser
        self._viewModel = StateObject(wrappedValue: PlaylistViewModel(selectedUser: selectedUser))
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            Spacer()
                            VStack {
                                AsyncImage(url: URL(string: selectedUser.imageURL)) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 200, height: 200)
                                            .cornerRadius(10)
                                    } else if phase.error != nil {
                                        Text("Görsel Yüklenemedi")
                                    } else {
                                        ProgressView()
                                    }
                                }
                                
                                Text(selectedUser.name)
                                    .font(.title)
                                    .foregroundColor(.white)
                            }
                            Spacer()
                        }
                        ForEach(selectedUser.songs) { song in
                            Button(action: {
                                viewModel.playOrPauseSong(song)
                            }) {
                                HStack {
                                    Text(song.name)
                                        .foregroundColor(viewModel.currentSong?.id == song.id ? .green : .white)
                                        .padding(.vertical, 4)
                                    
                                    Spacer()
                                }
                            }
                        }
                    }
                    .padding()
                }
                
                Spacer()
                
                if viewModel.currentSong != nil {
                    playerControls
                }
            }
        }
        .onDisappear {
            viewModel.stopTimer()
        }
    }
    
    private var playerControls: some View {
        VStack {
            HStack {
                if let currentSong = viewModel.currentSong, let userImage = viewModel.image {
                    Image(uiImage: userImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 44, height: 44)
                        .clipShape(Rectangle())
                        .cornerRadius(8)
                        .padding(.trailing, 8)
                    
                    Text(currentSong.name)
                        .foregroundColor(.white)
                        .font(.headline)
                }
                Spacer()
                Button(action: {
                    if let currentSong = viewModel.currentSong {
                        viewModel.playOrPauseSong(currentSong)
                    }
                }) {
                    Image(systemName: viewModel.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 44, height: 44)
                        .foregroundColor(.white)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.3))
            
            ProgressBar(value: $viewModel.playbackProgress)
                .frame(height: 3)
                .padding()
        }
    }
}

struct ProgressBar: View {
    @Binding var value: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color.gray.opacity(0.3))
                
                Rectangle()
                    .foregroundColor(.green)
                    .frame(width: CGFloat(value) * geometry.size.width)
            }
            .cornerRadius(1.5)
        }
    }
}
