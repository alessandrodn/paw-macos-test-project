//
//  Response.swift
//  Paw Test
//
//  Created by Alessandro Di Nepi on 29/10/2021.
//

struct Response: Codable {
  let args: [String: String]
  let data: String
  let files: [String: String]
  let form: [String: String]
  let headers: [String: String]
  let json: Squad
  let method: String
  let origin: String
  let url: String
}
