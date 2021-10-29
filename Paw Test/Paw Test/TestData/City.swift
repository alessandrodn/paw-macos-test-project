//
//  City.swift
//  Paw Test
//
//  Created by Alessandro Di Nepi on 29/10/2021.
//

enum City: CaseIterable {
  case honolulu
  case london
  case newYork
  case paris
  case rome
}

extension City: CustomStringConvertible {
  var description: String {
    switch self {
    case .honolulu: return "Honolulu"
    case .london: return "London"
    case .newYork: return "New York"
    case .paris: return "Paris"
    case .rome: return "Rome"
    }
  }
}
