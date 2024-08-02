import SwiftUI

struct PlaylistView: View {
    
    @Binding var image: String
    @Binding var colors: [Color]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: colors),
                           startPoint: .top,
                           endPoint: .init(x: 0.6, y: 0.6))
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        ZStack {
                            Image(image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 250, height: 250)
                                .clipped()
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                    }
                }
            }
        }
        
    }
}

#Preview {
    PlaylistView(image: .constant("sagopaImage"), colors: .constant([Color.gray.opacity(1), Color.black]))
}
