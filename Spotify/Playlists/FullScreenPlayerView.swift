import SwiftUI

struct FullScreenPlayerView: View {
    @ObservedObject var viewModel: PlaylistViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.6), Color.black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.down")
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Text("Now Playing")
                        .foregroundColor(.white)
                    Spacer()
                    Button(action: {
                    }) {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.white)
                    }
                }
                .padding()
                
                Spacer()
                
                if let currentSong = viewModel.currentSong {
                    AsyncImage(url: URL(string: viewModel.selectedUser.imageURL)) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 300, height: 300)
                                .cornerRadius(10)
                        } else {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray)
                                .frame(width: 300, height: 300)
                        }
                    }
                    .padding()
                    
                    VStack {
                        Text(currentSong.name)
                            .font(.title)
                            .foregroundColor(.white)
                        Text(viewModel.selectedUser.name)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding()
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Button(action: {
                        if let currentSong = viewModel.currentSong {
                            viewModel.addToLikedSongs(song: currentSong)
                        }
                    }) {
                        Image(systemName: "heart")
                            .foregroundColor(.white)
                            .font(.title2)
                    }
                    .padding(.bottom, 8)
                    
                    ProgressBar(value: $viewModel.playbackProgress)
                        .frame(height: 4)
                }
                .padding(.horizontal)
                
                HStack {
                    Text(formatTime(viewModel.playbackProgress * 30))
                        .font(.caption)
                        .foregroundColor(.gray)
                    Spacer()
                    Text(formatTime(30 - (viewModel.playbackProgress * 30)))
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                
                HStack(spacing: 40) {
                    Button(action: {
                        viewModel.restartSong()
                    }) {
                        Image(systemName: "backward.end.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    
                    Button(action: {
                        viewModel.togglePlayPause()
                    }) {
                        Image(systemName: viewModel.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                            .font(.system(size: 70))
                            .foregroundColor(.white)
                    }
                    
                    Button(action: {
                        viewModel.skipToEnd()
                    }) {
                        Image(systemName: "forward.end.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                }
                .padding()
                
                Spacer()
            }
        }
    }
    
    private func formatTime(_ time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}
