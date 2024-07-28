import SwiftUI

struct HomeView: View {
    var body: some View {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all) 
                Text("Home View")
                    .foregroundColor(.white)
            }
        }
}

#Preview {
    HomeView()
}
