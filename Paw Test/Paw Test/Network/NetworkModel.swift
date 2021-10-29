//
//  NetworkModel.swift
//  Paw Test
//
//  Created by Alessandro Di Nepi on 29/10/2021.
//

import Foundation
import Combine

enum NetworkServiceError: Error {
  case networkError(error: URLError)
  case jsonDecodingError
  case other(_ error: Error)
}

protocol NetworkServicePublisher {
  func createPublisherFor(_ model: Encodable) -> AnyPublisher<Response, NetworkServiceError>?
}
