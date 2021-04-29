import Foundation
import Combine
import CoreLocation

public final class NetworkManager {
    // MARK: - Private properties
    private let baseUrlString: String

    // MARK: - Init
    init(baseUrlString: String) {
        self.baseUrlString = baseUrlString
    }

    // MARK: - Private methods
    private func executeRequest<T: Codable>(_ request: URLRequest, completion: @escaping (Result<T, APIError>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  let data = data
            else {
                completion(.failure(.noResponse))
                return
            }

            guard (200 ... 299).contains(response.statusCode) else {
                if let error = error as? URLError {
                    completion(.failure(.url(error)))
                }
                else {
                    completion(.failure(.httpStatusCode(response.statusCode, data, response)))
                }
                return
            }

            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
                return
            }
            catch {
                if let error = error as? DecodingError {
                    completion(.failure(.decoding(error, data)))
                }
                else {
                    completion(.failure(.underlying(error)))
                }
            }
        }.resume()
    }

    private func createURLRequest(from requestType: APIRequestProtocol) -> URLRequest? {
        let urlString = baseUrlString + requestType.path

        guard var url = URL(string: urlString) else {
            return nil
        }

        if let queryParameters = requestType.queryParameters {
            var queryItems = [URLQueryItem]()
            for (name, value) in queryParameters {
                queryItems.append(.init(name: name, value: value))
            }
            if var urlComps = URLComponents(string: urlString) {
                urlComps.queryItems = queryItems
                if let queryUrl = urlComps.url {
                    url = queryUrl
                    print(url.absoluteString)
                }
            }
        }

        var request = URLRequest(url: url, timeoutInterval: 60)
        request.httpMethod = requestType.method.rawValue

        if let parameters = requestType.parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        }

        if let headers = requestType.headers {
            request.allHTTPHeaderFields = headers
        }

        return request
    }
}

// MARK: - Network
extension NetworkManager: NetworkDefinition {
    func getVenues(for coordinate: CLLocationCoordinate2D, keyword: String, completion: @escaping (Result<FoursquareResponse, APIError>) -> Void) {
        guard let request = createURLRequest(from: VenueSearchAPI.getVenues(coordinate: coordinate, keyword: keyword)) else {
            completion(.failure(.invalidUrlRequest))
            return
        }
        executeRequest(request, completion: completion)
    }
}
