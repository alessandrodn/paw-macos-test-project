//
//  Squad.swift
//  Paw Test
//
//  Created by Alessandro Di Nepi on 29/10/2021.
//

struct Squad: Hashable, Codable {
  let squadName: String
  let homeTown: String
  let formed: Int
  let active: Bool
  let members: [SquadMember]
}
