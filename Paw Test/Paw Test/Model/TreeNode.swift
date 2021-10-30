//
//  TreeNode.swift
//  Paw Test
//
//  Created by Alessandro Di Nepi on 31/10/2021.
//

import Foundation

enum TreeNodeType {
  case boolen
  case number
  case string
  case container
}

class TreeNode: NSObject {
  let type: TreeNodeType
  let key: String
  let value: String
  @objc let children: [TreeNode]

  init(type: TreeNodeType, key: String, value: String = "", children: [TreeNode] = []) {
    self.type = type
    self.key = key
    self.value = value
    self.children = children

    super.init()
  }

  @objc var isLeaf: Bool { children.isEmpty }
  @objc var count: Int { children.count }
  @objc var title: String { key }
  @objc var countOrValue: String {
    switch type {
    case .container:
      return String(children.count)
    default:
      return value
    }
  }
}
