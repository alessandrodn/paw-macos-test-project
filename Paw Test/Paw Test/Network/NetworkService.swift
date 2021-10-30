//
//  NetworkService.swift
//  Paw Test
//
//  Created by Alessandro Di Nepi on 29/10/2021.
//

import Foundation
import Combine

final class NetworkService {
  private let session: URLSession
  private let queue: DispatchQueue = DispatchQueue(label: "NetworkQueue", qos: .background)

  init(session: URLSession = .shared) {
    self.session = session
  }

  private func createRequest(for endpoint: Endpoint, with data: Data) -> URLRequest? {
    var request = URLRequest(url: endpoint.url)
    request.httpMethod = endpoint.httpMethod
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = data

    return request
  }

  private func computeResult(data: Data?, response: URLResponse?, error: Error?) -> NetworkServiceResult {
    if let error = error {
      return .failure(.networkError(errorMessage: error.localizedDescription))
    }

    guard let httpResponse = response as? HTTPURLResponse else {
      return .failure(.networkError(errorMessage: "Invalid HTTP response"))
    }

    guard httpResponse.isOk else {
      return .failure(.networkError(errorMessage: "Server returned response \(httpResponse.statusCode)"))
    }

    do {
      let response = try JSONDecoder().decode(NetworkResponse.self, from: data ?? Data())
      return .success(response)
    } catch {
      return .failure(.jsonDecodingError)
    }
  }

  private func performUpload(of request: Encodable, to endpoint: Endpoint, completion: @escaping (NetworkServiceResult) -> Void) {
    guard let data = request.asJSONData else {
      completion(.failure(.jsonEncodingError))
      return
    }

    guard let urlRequest = createRequest(for: endpoint, with: data) else {
      completion(.failure(.networkError(errorMessage: "Error creating URL request")))
      return
    }

    session.dataTask(with: urlRequest) { data, response, error in
      completion(self.computeResult(data: data, response: response, error: error))
    }.resume()
  }

  func upload(request: Encodable, to endpoint: Endpoint, completion: @escaping (NetworkServiceResult) -> Void) {
    queue.async { [weak self] in
      self?.performUpload(of: request, to: endpoint, completion: completion)
    }
  }
}

private extension Encodable {
  var asJSONData: Data? { try? JSONEncoder().encode(self) }
}

extension HTTPURLResponse {
  var isOk: Bool { 200..<300 ~= statusCode }
}
