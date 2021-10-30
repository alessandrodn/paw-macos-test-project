//
//  DataModel.swift
//  Paw Test
//
//  Created by Alessandro Di Nepi on 30/10/2021.
//

import Foundation

final class RequestDataStore {
  private let postSquadService: PostSquadService

  // TODO: Add basic persistency with UserDefaults
  private var requests: [String: TreeNode] = [:]

  // This protect from accessing requests from multiple thread
  // Can be removed by implementing RequestDataStore as actor
  private let queue: DispatchQueue = DispatchQueue(label: "DataModelQueue", qos: .background)

  init(postSquadService: PostSquadService) {
    self.postSquadService = postSquadService
  }

  private func getCurrentDateTime() -> String {
    return DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .medium)
  }

  private func createRequestKeyForSquad(_ squad: Squad) -> String {
    let squadName = squad.squadName
    let requestNumber = requests.count + 1
    let currentTime = getCurrentDateTime()
    return "Req. \(requestNumber) - \(squadName) - \(currentTime)"
  }

  private func processResult(_ result: PostSquadServiceResult, for title: String, completion: @escaping (Result<String, Error>) -> Void) {
    switch result {
    case .success(let tree):
      queue.sync {
        requests[title] = tree
      }

      completion(.success(title))

    case .failure(let error):
      completion(.failure(error))
    }
  }
}

extension RequestDataStore: RequestDataSource {
  func generateNewRequest(_ completion: @escaping (Result<String, Error>) -> Void) {
    let testSquad = SquadGenerator.generateTestSquad()
    let requestKey = createRequestKeyForSquad(testSquad)

    postSquadService.postSquad(testSquad) { [weak self] result in
      self?.processResult(result, for: requestKey, completion: completion)
    }
  }

  func requestWithTitle(_ title: String) -> TreeNode? {
    return requests[title]
  }

  func getAllTitles() -> [String] {
    return Array(requests.keys)
  }

  func removeAll() {
    queue.sync {
      requests.removeAll()
    }
  }
}
