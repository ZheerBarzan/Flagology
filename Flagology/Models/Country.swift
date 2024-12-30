struct Country: Codable, Identifiable {
    let name: Name
    let flags: Flags

    var id: String { name.common }

    struct Name: Codable {
        let common: String
    }

    struct Flags: Codable {
        let png: String
    }
}
