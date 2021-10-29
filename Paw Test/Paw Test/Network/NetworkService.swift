//
//  NetworkService.swift
//  Paw Test
//
//  Created by Alessandro Di Nepi on 29/10/2021.
//

import Foundation
import Combine

final class NetworkService: NetworkServicePublisher {
  private let session: URLSession

  init(session: URLSession = .shared) {
    self.session = session
  }

  func createPublisherFor(_ model: Encodable) -> AnyPublisher<Response, NetworkServiceError>? {
    guard let data = model.toJSONData(),
          let request = setupRequest(for: .httpbin, with: data) else { return nil }

    return session.dataTaskPublisher(for: request)
      .map { $0.data }
      .print()
      .decode(type: Response.self, decoder: JSONDecoder())
      .print()
      .mapError({ error in
        switch error {
        case let urlError as URLError:
          print("Network request to \(String(describing: urlError.failureURLString)) failed with: \(urlError.localizedDescription)")
          return .networkError(error: urlError)
        case is Swift.DecodingError:
          print("JSON decoding failed with: \(error.localizedDescription)")
          return .jsonDecodingError
        default:
          print("Unknown error: \(error.localizedDescription)")
          return .other(error)
        }
      })
      .eraseToAnyPublisher()
  }

  private func setupRequest(for endpoint: Endpoint, with data: Data) -> URLRequest? {
    var urlComponents = URLComponents()
    urlComponents.scheme = endpoint.scheme
    urlComponents.host = endpoint.serverHost
    urlComponents.path = endpoint.uri

    guard let url = urlComponents.url else {
      print("URL generation failed!")
      return nil
    }

    var request = URLRequest(url: url)
    request.httpMethod = endpoint.httpMethod
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = data

    return request
  }
}

private extension Encodable {
  func toJSONData() -> Data? {
    return try? JSONEncoder().encode(self)
  }
}
