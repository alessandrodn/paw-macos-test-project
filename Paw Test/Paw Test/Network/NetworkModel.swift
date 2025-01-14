//
//  NetworkModel.swift
//  Paw Test
//
//  Created by Alessandro Di Nepi on 29/10/2021.
//

import Foundation

struct NetworkResponse: Codable {
  let data: String
}

enum NetworkServiceError: Error {
  case jsonEncodingError
  case networkError(errorMessage: String)
  case jsonDecodingError
  case other(errorMessage: String)
}

typealias NetworkServiceResult = Result<NetworkResponse, NetworkServiceError>
