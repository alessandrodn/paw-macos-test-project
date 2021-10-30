//
//  Endpoint.swift
//  Paw Test
//
//  Created by Alessandro Di Nepi on 29/10/2021.
//

import Foundation

enum Endpoint {
  case anything

  var scheme: String {
    switch self {
    case .anything: return "https"
    }
  }
  
  var serverHost: String {
    switch self {
    case .anything: return "httpbin.org"
    }
  }
  
  var uri: String {
    switch self {
    case .anything: return "/anything"
    }
  }

  var httpMethod: String {
    switch self {
    case .anything: return "POST"
    }
  }

  var url: URL {
    var urlComponents = URLComponents()
    urlComponents.scheme = scheme
    urlComponents.host = serverHost
    urlComponents.path = uri

    // Prefer to crash to spot any error in typing
    return urlComponents.url!
  }
}
