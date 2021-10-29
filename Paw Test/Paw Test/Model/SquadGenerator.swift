//
//  SquadGenerator.swift
//  Paw Test
//
//  Created by Alessandro Di Nepi on 29/10/2021.
//

struct SquadGenerator {
  static func generateTestSquad() -> Squad {

    return Squad(squadName: SquadName.allCases.randomElement()?.description ?? "Unknown squad",
                 homeTown: City.allCases.randomElement()?.description ?? "Unknown city",
                 formed: Int.random(in: 1970...2020),
                 active: Int.random(in: 0...1) == 0,
                 members: generateSquadMembers())
  }

  private static func generateSquadMembers() -> [SquadMember] {
    var members: Set<SquadMember> = []

    for _ in 1...Int.random(in: 1...3) {
      members.insert(SquadMember(name: Nickname.randomNickname,
                                 age: Int.random(in: 18...80),
                                 secretIdentity: Name.allCases.randomElement()?.description ?? "Unknown",
                                 powers: generateSquadMemberPowers()))
    }

    return Array(members)
  }

  private static func generateSquadMemberPowers(maxNumbersOfPowers: Int = Power.allCases.count) -> [String] {
    var powers: Set<String> = []

    for _ in 1...Int.random(in: 1...3) {
      powers.insert(Power.allCases.randomElement()?.description ?? "Unknown")
    }
    return Array(powers)
  }
}

private extension Nickname {
  static var randomNickname: String {
    (1...2)
      .map { _ in allCases.randomElement()?.description ?? "Unknown" }
      .reduce("") { "\($0) \($1)" }
  }
}
