/// A model representing a country with its name and flag information
struct Country: Codable, Identifiable {
    /// The name information of the country
    let name: Name
    /// The flag information of the country
    let flags: Flags

    /// Unique identifier for the country, using its common name
    var id: String { name.common }

    /// Nested structure for country name information
    struct Name: Codable {
        /// The common name of the country
        let common: String
    }

    /// Nested structure for country flag information
    struct Flags: Codable {
        /// The URL string for the PNG version of the flag
        let png: String
    }
}
