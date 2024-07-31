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
            
            VStack {
                HStack {
                    Text(greetingMessage())
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                    Spacer()
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

#Preview {
    HomeView()
}
