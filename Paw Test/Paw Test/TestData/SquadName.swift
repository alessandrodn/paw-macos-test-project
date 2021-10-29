//
//  SquadName.swift
//  Paw Test
//
//  Created by Alessandro Di Nepi on 29/10/2021.
//

enum SquadName: Hashable, CaseIterable {
  case planets
  case presidents
  case superhero
}

extension SquadName: CustomStringConvertible {
  var description: String {
    switch self {
    case .planets: return "Planets squad"
    case .presidents: return "Presidents squad"
    case .superhero: return "Super hero squad"
    }
  }
}
