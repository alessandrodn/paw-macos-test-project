//
//  DataModel.swift
//  Paw Test
//
//  Created by Alessandro Di Nepi on 30/10/2021.
//

import Foundation

final class RequestDataStore {
  private var requests: [String: String] = [:]

  private func getCurrentDateTime() -> String {
    return DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .medium)
  }

  private func createRequestKeyForSquad(_ squad: Squad) -> String {
    let squadName = squad.squadName
    let requestNumber = requests.count + 1
    let currentTime = getCurrentDateTime()
    return "Req. \(requestNumber) - \(squadName) - \(currentTime)"
  }
}

extension RequestDataStore: RequestDataSource {
  func generateNewRequest(_ completion: @escaping (String) -> Void) {
    let testSquad = SquadGenerator.generateTestSquad()
    let requestKey = createRequestKeyForSquad(testSquad)

    // TODO: This will come from the network response
    let jsonData = try! JSONEncoder().encode(testSquad)
    requests[requestKey] = String(data: jsonData, encoding: .utf8)

    completion(requestKey)
  }

  func requestWithTitle(_ title: String) -> String? {
    return requests[title]
  }

  func getAll() -> [String] {
    return Array(requests.values)
  }

  func removeAll() {
    requests.removeAll()
  }
}
