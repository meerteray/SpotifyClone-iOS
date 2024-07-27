import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Image("spotifyLogo")
                    .resizable()
                    .renderingMode(.template)
                       .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                
                Text("Millions of songs.")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 30)
                
                Text("Free on Spotify.")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 40)
                
                Button(action: {
                }) {
                    Text("Sign up free")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(25)
                        .padding(.horizontal, 40)
                }
                .padding(.bottom, 10)
                
                Button(action: {
                   
                }) {
                    HStack {
                        Image(systemName: "g.circle.fill")
                            .foregroundColor(.green)
                        Text("Continue with Google")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(25)
                    .padding(.horizontal, 40)
                }
                .padding(.bottom, 10)
                
                Button(action: {
                }) {
                    HStack {
                        Image(systemName: "f.cursive.circle.fill")
                            .foregroundColor(.blue)
                        Text("Continue with Facebook")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(25)
                    .padding(.horizontal, 40)
                }
                .padding(.bottom, 10)
                
                Button(action: {
                }) {
                    HStack {
                        Image(systemName: "applelogo")
                            .foregroundColor(.white)
                        Text("Continue with Apple")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(25)
                    .padding(.horizontal, 40)
                }
                .padding(.bottom, 10)
                
                Button(action: {
                }) {
                    Text("Log in")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.top, 10)
                }
                Spacer()
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
        }
    }
}

#Preview {
    ContentView()
}
