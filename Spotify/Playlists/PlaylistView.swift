import SwiftUI

struct PlaylistView: View {
    @StateObject private var viewModel: PlaylistViewModel
    @State private var showFullScreenPlayer = false
    @State private var isLikedSongs = false
    
    init(selectedUser: User, isLikedSongs: Bool) {
        _viewModel = StateObject(wrappedValue: PlaylistViewModel(selectedUser: selectedUser, isLikedSongs: isLikedSongs))
        print("liked songs bla bla \(isLikedSongs)")
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
                        .onTapGesture {
                            showFullScreenPlayer = true
                        }
                }
            }
        }
        .onDisappear {
            viewModel.stopTimer()
            
        }
        .fullScreenCover(isPresented: $showFullScreenPlayer) {
            FullScreenPlayerView(viewModel: viewModel)
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
        LazyVStack(spacing: 16) {
            ForEach(viewModel.songtype) { song in
                Button(action: {
                    viewModel.playOrPauseSong(song)
                }) {
                    HStack(spacing: 12) {
                        AsyncImage(url: URL(string: viewModel.selectedUser.imageURL)) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 48, height: 48)
                                    .clipShape(RoundedRectangle(cornerRadius: 4))
                            } else {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 48, height: 48)
                            }
                        }
                        .frame(width: 48, height: 48)
                        
                        if viewModel.currentSong?.id == song.id && viewModel.isPlaying {
                            PlayingAnimation()
                                .frame(width: 14, height: 14)
                                .padding(.trailing, 4)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(song.name)
                                .font(.body)
                                .foregroundColor(viewModel.currentSong?.id == song.id ? .green : .white)
                            Text(viewModel.selectedUser.name)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                    }
                    .padding(.vertical, 4)
                }
                .padding(.horizontal, 8)
            }
        }
        .padding(.leading, 8)
    }
    
    private var playerControls: some View {
        VStack(spacing: 0) {
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
        .background(Color.gray.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .padding(.horizontal)
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

struct PlayingAnimation: View {
    @State private var isAnimating = false
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<3) { index in
                Capsule()
                    .fill(Color.green)
                    .frame(width: 2, height: 14)
                    .scaleEffect(y: isAnimating ? 1 : 0.3, anchor: .bottom)
                    .animation(
                        Animation
                            .easeInOut(duration: 0.5)
                            .repeatForever()
                            .delay(Double(index) * 0.2),
                        value: isAnimating
                    )
            }
        }
        .frame(width: 14, height: 14)
        .onAppear {
            isAnimating = true
        }
    }
}

