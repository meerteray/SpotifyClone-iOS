import SwiftUI

struct MainView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(.black)
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
       }

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image("homeLogo")
                    Text("Home")
                }
            
            SearchView()
                .tabItem {
                    Image("searchLogo")
                    Text("Search")
                }
            
            LibraryView()
                .tabItem {
                    Image("libraryLogo")
                    Text("Your Library")
                }
        }
        .accentColor(.white)
       // .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}
#Preview {
    MainView()
}
