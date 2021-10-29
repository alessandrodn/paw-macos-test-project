//
//  Powers.swift
//  Paw Test
//
//  Created by Alessandro Di Nepi on 29/10/2021.
//

enum Power: Hashable, CaseIterable {
  case radiationResistance
  case turningTiny
  case radiationBlast
  case millionTonnePunch
  case damageResistance
  case superhumanReflexes
  case immortality
  case heatImmunity
  case inferno
  case teleportation
  case interdimensional
}

extension Power: CustomStringConvertible {
  var description: String {
    switch self {
    case .radiationResistance: return "Radiation resistance"
    case .turningTiny: return "Turning tiny"
    case .radiationBlast: return "Radiation blast"
    case .millionTonnePunch: return "Million tonne punch"
    case .damageResistance: return "Damage resistance"
    case .superhumanReflexes: return "Superhuman reflexes"
    case .immortality: return "Immortality"
    case .heatImmunity: return "Heat Immunity"
    case .inferno: return "Inferno"
    case .teleportation: return "Teleportation"
    case .interdimensional: return "Interdimensional"
    }
  }
}
