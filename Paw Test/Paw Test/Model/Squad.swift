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

extension Squad {
  var asTreeNode: TreeNode {
    let squadNameNode = TreeNode(type: .string, key: "Squad Name", value: squadName)
    let townNode = TreeNode(type: .string, key: "Hometown", value: String(homeTown))
    let formedNode = TreeNode(type: .string, key: "Formed", value: String(formed))
    let activeNode = TreeNode(type: .boolen, key: "Active", value: String(active))

    let membersNodes = members.enumerated().map { index, member in
      member.asTreeNode(title: "Member \(index + 1)")
    }
    let membersNode = TreeNode(type: .container, key: "Members", children: membersNodes)

    let children = [squadNameNode, townNode, formedNode, activeNode, membersNode]
    return TreeNode(type: .container, key: "Root", children: children)
  }
}
