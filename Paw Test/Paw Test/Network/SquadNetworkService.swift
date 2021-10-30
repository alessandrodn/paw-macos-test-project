//
//  SquadNetworkService.swift
//  Paw Test
//
//  Created by Alessandro Di Nepi on 31/10/2021.
//

import Foundation

typealias PostSquadServiceResult = Result<TreeNode, NetworkServiceError>

protocol PostSquadService {
  func postSquad(_ squad: Squad, _ completion: @escaping (PostSquadServiceResult) -> Void)
}

extension NetworkService: PostSquadService {
  func postSquad(_ squad: Squad, _ completion: @escaping (PostSquadServiceResult) -> Void) {
    upload(request: squad, to: .anything) { result in
      switch result {
      case .success(let response):
        let dataString = response.data
        guard let squad = try? JSONDecoder().decode(Squad.self, from: dataString.data(using: .utf8) ?? Data()) else {
          completion(.failure(.other(errorMessage: "Error parsing network result")))
          return
        }

        completion(.success(squad.asTreeNode))

      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
