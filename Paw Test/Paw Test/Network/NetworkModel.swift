//
//  NetworkModel.swift
//  Paw Test
//
//  Created by Alessandro Di Nepi on 29/10/2021.
//

import Foundation
import Combine

struct NetworkResponse: Codable {
  let data: String
}

enum NetworkServiceError: Error {
  case jsonEncodingError
  case networkError(errorMessage: String)
  case jsonDecodingError
  case other(error: Error)
}

typealias NetworkServiceResult = Result<NetworkResponse, NetworkServiceError>

protocol SquadNetworkService {
  func postSquad(_ squad: Squad, _ completion: @escaping (NetworkServiceResult) -> Void)
}

