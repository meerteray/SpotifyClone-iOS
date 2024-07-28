import SwiftUI

struct LibraryView: View {
    var body: some View {
           ZStack {
               Color.black.edgesIgnoringSafeArea(.all) 
               Text("Library View")
                   .foregroundColor(.white)
           }
       }
   }
#Preview {
    LibraryView()
}
