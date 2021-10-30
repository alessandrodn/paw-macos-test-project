//
//  SquadMember.swift
//  Paw Test
//
//  Created by Alessandro Di Nepi on 29/10/2021.
//

struct SquadMember: Hashable, Codable {
  let name: String
  let age: Int
  let secretIdentity: String
  let powers: [String]
}

extension SquadMember {
  func asTreeNode(title: String) -> TreeNode {
    let nameNode = TreeNode(type: .string, key: "Squad Name", value: name)
    let ageNode = TreeNode(type: .number, key: "Age", value: String(age))
    let identityNode = TreeNode(type: .string, key: "Secret Identity", value: secretIdentity)

    let powersNodes = powers.enumerated().map { index, power in
      TreeNode(type: .string, key: "Power \(index + 1)", value: power)
    }
    let powersNode = TreeNode(type: .container, key: "Powers", children: powersNodes)

    let children = [nameNode, ageNode, identityNode, powersNode]
    return TreeNode(type: .container, key: title, children: children)
  }
}
