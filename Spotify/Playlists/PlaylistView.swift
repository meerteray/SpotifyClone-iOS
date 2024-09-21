import SwiftUI

struct PlaylistView: View {
    @StateObject private var viewModel: PlaylistViewModel
    
    init(selectedUser: User) {
        _viewModel = StateObject(wrappedValue: PlaylistViewModel(selectedUser: selectedUser))
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        userHeader
                        songList
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
    
    private var userHeader: some View {
        HStack {
            Spacer()
            VStack {
                AsyncImage(url: URL(string: viewModel.selectedUser.imageURL)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 200, height: 200)
                            .cornerRadius(10)
                    } else if phase.error != nil {
                        Text("Görsel Yüklenemedi")
                    } else {
                        ProgressView()
                    }
                }
                Text(viewModel.selectedUser.name)
                    .font(.title)
                    .foregroundColor(.white)
            }
            Spacer()
        }
    }
    
    private var songList: some View {
        ForEach(viewModel.selectedUser.songs) { song in
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
    
    private var playerControls: some View {
        VStack {
            HStack {
                if let currentSong = viewModel.currentSong {
                    AsyncImage(url: URL(string: viewModel.selectedUser.imageURL)) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 44, height: 44)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        } else {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray)
                                .frame(width: 44, height: 44)
                        }
                    }
                    .frame(width: 44, height: 44)
                    .padding(.trailing, 8)
                    
                    VStack(alignment: .leading) {
                        Text(currentSong.name)
                            .foregroundColor(.white)
                            .font(.headline)
                        Text(viewModel.selectedUser.name)
                            .foregroundColor(.gray)
                            .font(.subheadline)
                    }
                }
                Spacer()
                Button(action: {
                    viewModel.togglePlayPause()
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
                .padding(.horizontal)
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
