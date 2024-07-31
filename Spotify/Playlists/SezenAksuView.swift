import SwiftUI

struct SezenAksuView: View {
    @State private var isButtonPressed = false
        
    var body: some View {
        VStack {
            LinearGradient(gradient: Gradient(colors: [Color.red.opacity(1), Color.black]),
                           startPoint: .top,
                           endPoint: .init(x: 0.6, y: 0.6))
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
                    
                    VStack {
                        
                        Button(action: {
                            isButtonPressed.toggle()
                            print("Kaybolan Yılları çal")
                        }) {
                            HStack(alignment: .center) {
                                Image("kaybolanYıllarImage")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                
                                Text("Kaybolan Yıllar")
                                    .padding(.vertical, 10)
                                    .foregroundColor(isButtonPressed ? .green : .white)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.black)
                        }
                        
                        .padding(.horizontal)
                    }
                    .padding(.bottom)
                    
                    Spacer()
                }
            )
        }
    }
}

#Preview {
    SezenAksuView()
}
