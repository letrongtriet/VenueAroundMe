import Foundation

// MARK: - FoursquareResponse
struct FoursquareResponse: Codable, Equatable {
    let response: Response?
}

// MARK: - Response
struct Response: Codable, Equatable {
    let venues: [Venue]?
}

// MARK: - ItemVenue
struct Venue: Codable, Equatable {
    let id, name: String?
    let location: Location?
}

// MARK: - Location
struct Location: Codable, Equatable {
    let address: String?
    let lat, lng: Double?
    let distance: Int?
}
