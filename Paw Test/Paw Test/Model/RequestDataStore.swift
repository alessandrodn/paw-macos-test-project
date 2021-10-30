//
//  DataModel.swift
//  Paw Test
//
//  Created by Alessandro Di Nepi on 30/10/2021.
//

import Foundation

final class RequestDataStore {
  private let networkService: SquadNetworkService

  // TODO: Add basic persistency with UserDefaults
  private var requests: [String: String] = [:]

  // This protect from accessing requests from multiple thread
  // Can be removed by implementing RequestDataStore as actor
  private let queue: DispatchQueue = DispatchQueue(label: "DataModelQueue", qos: .background)

  init(networkService: SquadNetworkService) {
    self.networkService = networkService
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

  private func processResponse(_ responseData: String, for title: String) {
    queue.sync {
      requests[title] = responseData
    }

  }
}

extension RequestDataStore: RequestDataSource {
  func generateNewRequest(_ completion: @escaping (String) -> Void) {
    let testSquad = SquadGenerator.generateTestSquad()
    let requestKey = createRequestKeyForSquad(testSquad)

    networkService.postSquad(testSquad) { [weak self] result in
      switch result {
      case .success(let response):
        self?.processResponse(response.data, for: requestKey)
        completion(requestKey)
      case .failure(let error):
        // TODO: Transmit back to the view the error
        print("Error")
      }
    }
  }

  func requestWithTitle(_ title: String) -> String? {
    return requests[title]
  }

  func getAll() -> [String] {
    return Array(requests.values)
  }

  func removeAll() {
    queue.sync {
      requests.removeAll()
    }
  }
}
