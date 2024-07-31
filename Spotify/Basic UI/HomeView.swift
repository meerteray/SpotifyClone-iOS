import SwiftUI

struct HomeView: View {
    
    func greetingMessage() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 6..<12:
            return "Good Morning"
        case 12..<17:
            return "Good Afternoon"
        case 17..<22:
            return "Good Evening"
        default:
            return "Good Night"
        }
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 20) {
                Text(greetingMessage())
                    .foregroundColor(.white)
                    .font(.title)
                    .bold()
                
                VStack(spacing: 10) {
                    HStack(spacing: 10) {
                        createButton(title: "This Is", subtitle: "Sezen Aksu", imageName: "sezenAksuImage")
                        createButton(title: "Liked", subtitle: "Songs", imageName: "likedSongsImage")
                    }
                    HStack(spacing: 10) {
                        createButton(title: "No.1", subtitle: "", imageName: "no1Image")
                        createButton(title: "This Is", subtitle: "Eminem", imageName: "eminemImage")
                    }
                    HStack(spacing: 10) {
                        createButton(title: "This Is", subtitle: "Kanye West", imageName: "kanyewestImage")
                        createButton(title: "Ceza", subtitle: "", imageName: "cezaImage")
                    }
                    HStack(spacing: 10) {
                        createButton(title: "Sagopa", subtitle: "Kajmer", imageName: "sagopaImage")
                        createButton(title: "Sefo", subtitle: "", imageName: "sefoImage")
                    }
                }
                
                Spacer()
            }
            .padding()
        }
    }
    
    func createButton(title: String, subtitle: String, imageName: String) -> some View {
        Button(action: { print("\(title) \(subtitle) tapped") }) {
            HStack {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
                    if !subtitle.isEmpty {
                        Text(subtitle)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10)
        }
    }
}

#Preview {
    HomeView()
}
