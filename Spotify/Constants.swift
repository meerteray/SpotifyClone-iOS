import SwiftUI

struct Constants {
    let artistSongs: [String: [String]] = [
        "Sezen Aksu": [
            "Kaybolan Yıllar",
            "Firuze",
            "Gülümse",
            "Seni Yerler",
            "Kutlama",
            "Hadi Bakalım",
            "İkili Delilik",
            "Aldatıldık",
            "Tutsak"
        ],
        "No.1": [
            "Yarım Kalan Sigara",
            "Bu Benim Hayatım",
            "Hiç Işık Yok",
            "Böyle İyi"
        ],
        "Eminem": [
            "Mockingbird",
            "Superman",
            "Without me",
            "Houdini"
        ],
        "Kanye West": [
            "Heartless",
            "Flashing Lights",
            "All Falls Down",
            "Homecoming"
        ],
        "Ceza": [
            "Med Cezir",
            "Gelsin Hayat Bildiği Gibi",
            "Suspus",
            "Kim Bilir"
        ],
        "Sagopa Kajmer": [
            "24",
            "Onlarla Konuşuyorum",
            "Bir Pesimistin Gözyaşları",
            "Karikatür Komedya"
        ],
        "Sefo": [
            "KAPALI KAPILAR",
            "ARABA",
            "kördüğüm",
            "Bilmem mi?"
        ]
    ]
}

struct PlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistView(
            image: .constant("sagopaImage"),
            colors: .constant([Color.gray.opacity(1), Color.black]),
            songs: .constant(Constants().artistSongs["Sagopa Kajmer"] ?? []),
            artist: .constant("Sagopa Kajmer")
        )
    }
}
