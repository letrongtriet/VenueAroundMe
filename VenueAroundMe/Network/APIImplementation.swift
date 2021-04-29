import Foundation

extension VenueSearchAPI {
    var path: String {
        switch self {
        case .getVenues:
            return "/v2/venues/search"
        }
    }

    var method: RequestMethod {
        switch self {
        case .getVenues:
            return .get
        }
    }

    var headers: ReaquestHeaders? {
        nil
    }

    var parameters: RequestParameters? {
        nil
    }

    var queryParameters: RequestQueryParameters? {
        switch self {
        case let .getVenues(coordinate, keyword):
            // \(String(format: "%.4f", coordinate.latitude)),\(String(format: "%.4f", coordinate.longitude))
            var toRet = ["ll": "\(coordinate.latitude),\(coordinate.longitude)"]
            toRet["limit"] = Constants.API.limit
            toRet["client_secret"] = Constants.API.apiSecret
            toRet["client_id"] = Constants.API.apiKey
            toRet["v"] = Constants.API.apiVersion
            toRet["query"] = keyword
            return toRet
        }
    }
}
