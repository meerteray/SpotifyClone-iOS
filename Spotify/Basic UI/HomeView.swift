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
                        createButton(title: "This Is Sezen Aksu", action: { print("Button 1 tapped") })
                        createButton(title: "Liked Songs", action: { print("Button 2 tapped") })
                    }
                    HStack(spacing: 10) {
                        createButton(title: "No.1", action: { print("Button 3 tapped") })
                        createButton(title: "This Is Eminem", action: { print("Button 4 tapped") })
                    }
                    HStack(spacing: 10) {
                        createButton(title: "This Is Kanye West", action: { print("Button 5 tapped") })
                        createButton(title: "Ceza", action: { print("Button 6 tapped") })
                    }
                    HStack(spacing: 10) {
                        createButton(title: "Sagopa Kajmer", action: { print("Button 7 tapped") })
                        createButton(title: "Sefo", action: { print("Button 8 tapped") })
                    }
                }
                
                Spacer()
            }
            .padding()
        }
    }
    
    func createButton(title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.3))
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}

#Preview {
    HomeView()
}
