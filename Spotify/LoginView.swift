import SwiftUI

struct LoginView: View {
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
                
                NavigationLink(destination: MainView()) {
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
                
                NavigationLink(destination: MainView()) {
                    HStack {
                        Image("googleLogo")
                            .resizable()
                            .frame(width: 24, height: 24)
                        Spacer()
                        Text("Continue with Google")
                            .font(.headline)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.white, lineWidth: 2)
                    )
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(25)
                    .padding(.horizontal, 40)
                }
                .padding(.bottom, 10)
                
                NavigationLink(destination: MainView()) {
                    HStack {
                        Image("facebookLogo")
                            .resizable()
                            .frame(width: 24, height: 24)
                        Spacer()
                        Text("Continue with Facebook")
                            .font(.headline)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.white, lineWidth: 2)
                    )
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(25)
                    .padding(.horizontal, 40)
                }
                .padding(.bottom, 10)
                
                NavigationLink(destination: MainView()) {
                    HStack {
                        Image("appleLogo")
                            .resizable()
                            .frame(width: 24, height: 24)
                        Spacer()
                        Text("Continue with Apple")
                            .font(.headline)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.white, lineWidth: 2)
                    )
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(25)
                    .padding(.horizontal, 40)
                }
                .padding(.bottom, 10)
                
                NavigationLink(destination: MainView()) {
                    Text("Log in")
                        .font(.headline)
                        .fontWeight(.bold)
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
    LoginView()
}
