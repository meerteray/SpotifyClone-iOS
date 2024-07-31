import SwiftUI

struct SearchView: View {
    var body: some View {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all) 
                Text("Search View")
                    .foregroundColor(.white)
            }
        }
}
#Preview {
    SearchView()
}
