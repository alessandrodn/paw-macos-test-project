//
//  Nickname.swift
//  Paw Test
//
//  Created by Alessandro Di Nepi on 29/10/2021.
//

enum Nickname: Hashable, CaseIterable {
  case eternal
  case flame
  case madame
  case man
  case mister
  case molecule
  case uppercut
}

extension Nickname: CustomStringConvertible {
  var description: String {
    switch self {
    case .eternal: return "Eternal"
    case .flame: return "Flame"
    case .madame: return "Madame"
    case .man: return "Man"
    case .mister: return "Mister"
    case .molecule: return "Molecule"
    case .uppercut: return "Uppercut"
    }
  }
}
