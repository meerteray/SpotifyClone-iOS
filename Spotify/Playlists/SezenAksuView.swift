import SwiftUI

struct SezenAksuView: View {
    var body: some View {
        VStack {
            LinearGradient(gradient: Gradient(colors: [Color.red.opacity(1), Color.black]),
                           startPoint: .top,
                           endPoint: .init(x: 0.5, y: 0.5))
            .edgesIgnoringSafeArea(.all)
            .overlay(
                VStack {
                    ZStack {
                        Image("sezenAksuImage")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 250, height: 250)
                            .clipped()
                    }
                    .padding()
                    
                    Text("This is Sezen Aksu, The essential tracks, all in one playlist.")
                        .font(.system(size: 13))
                        .foregroundColor(.white)
                    
                    Button(action: {
                        print("Kaybolan Yılları çal")
                    }) {
                        Text("Kaybolan Yıllar")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal)

                    Spacer()
                        .navigationBarBackButtonHidden(true)

                }
            )
        }
    }
}

#Preview {
    SezenAksuView()
}
