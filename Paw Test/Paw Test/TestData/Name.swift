//
//  Name.swift
//  Paw Test
//
//  Created by Alessandro Di Nepi on 29/10/2021.
//

enum Name: Hashable, CaseIterable {
  case alex
  case alice
  case bob
  case dan
  case jane
  case joe
  case will
}

extension Name: CustomStringConvertible {
  var description: String {
    switch self {
    case .alex: return "Alex Nilson"
    case .alice: return "Alice Regan"
    case .bob: return "Bob Bush"
    case .dan: return "Dan Kaminsky"
    case .jane: return "Jane Fonda"
    case .joe: return "Joe Black"
    case .will: return "Will Smith"
    }
  }
}
