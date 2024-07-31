import SwiftUI

struct SezenAksuView: View {
    var body: some View {
            VStack {
                LinearGradient(gradient: Gradient(colors: [Color.red.opacity(2), Color.black]),
                               startPoint: .top,
                               endPoint: .bottom)
                
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
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                
                            }) {
                                Button(action: {
                                    print("Button tapped!")
                                }) {
                                    Text("Kaybolan Yıllar")
                                        .padding()
                                        .background(Color.black)
                                        .foregroundColor(.white)
                                }
                            }
                            Spacer()
                        }
                        .padding()
                        Spacer()
                    }
                )
            .navigationBarBackButtonHidden(true)

        }
    }
}

#Preview {
    SezenAksuView()
}
