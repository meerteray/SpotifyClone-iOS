import SwiftUI

struct MainView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = .black
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
        UITabBar.appearance().barTintColor = .black
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            TabView {
                HomeView()
                    .tabItem {
                        Image("homeLogo")
                        Text("Home")
                    }
                    .background(Color.black) 
                
                SearchView()
                    .tabItem {
                        Image("searchLogo")
                        Text("Search")
                    }
                    .background(Color.black)
                
                LibraryView()
                    .tabItem {
                        Image("libraryLogo")
                        Text("Your Library")
                    }
                    .background(Color.black) 
            }
            .accentColor(.white)
        }
    }
}
    #Preview {
        MainView()
    }
