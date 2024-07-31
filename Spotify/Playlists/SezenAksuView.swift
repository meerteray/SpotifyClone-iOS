import SwiftUI

struct SezenAksuView: View {
    var body: some View {
        VStack {
            Text("Sezen Aksu")
                .font(.largeTitle)
                .padding()
            Text("Bu ekran Sezen Aksu hakkında bilgiler içeriyor.")
            Spacer()
        }
        .navigationTitle("Sezen Aksu") // Ekran başlığını ayarlıyoruz
        .padding()
    }
}

#Preview {
    SezenAksuView()
}

