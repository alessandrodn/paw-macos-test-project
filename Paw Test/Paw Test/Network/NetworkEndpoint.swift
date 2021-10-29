//
//  Endpoint.swift
//  Paw Test
//
//  Created by Alessandro Di Nepi on 29/10/2021.
//

enum Endpoint {
  case httpbin

  var scheme: String {
    switch self {
    case .httpbin: return "https"
    }
  }
  
  var serverHost: String {
    switch self {
    case .httpbin: return "httpbin.org"
    }
  }
  
  var uri: String {
    switch self {
    case .httpbin: return "/anything"
    }
  }

  var httpMethod: String {
    switch self {
    case .httpbin: return "POST"
    }
  }
}
