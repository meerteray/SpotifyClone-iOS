import SwiftUI

struct ContentView: View {
    @State private var scrollOffset: CGFloat = 0

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(0..<50) { index in
                    Text("Item \(index)")
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
            }
            .background(GeometryReader { geometry -> Color in
                DispatchQueue.main.async {
                    let offset = geometry.frame(in: .global).minY
                    scrollOffset = offset

                    // Belirli bir pozisyonu geçtiğinde işlem yap
                    if offset < -200 { // Pozisyonu buradan ayarlayabilirsiniz
                        print("ScrollView bu pozisyonu geçti: \(offset)")
                    }
                }
                return Color.clear
            })
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
