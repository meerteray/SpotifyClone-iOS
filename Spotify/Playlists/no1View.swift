import SwiftUI

struct no1View: View {
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(1), Color.black]),
                           startPoint: .top,
                           endPoint: .init(x: 0.6, y: 0.6))
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        ZStack {
                            Image("no1Image")
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
    no1View()
}
