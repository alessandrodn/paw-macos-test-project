//
//  AppDelegate.swift
//  Paw Test
//
//  Created by Alessandro Di Nepi on 29/10/2021.
//

import Cocoa
import Combine

@main
class AppDelegate: NSObject, NSApplicationDelegate {
  var cancellable: Cancellable?
  


  func applicationDidFinishLaunching(_ aNotification: Notification) {
    // Insert code here to initialize your application

    let testSquad = SquadGenerator.generateTestSquad()
    print("Test Squad: \(testSquad)")

    let networkService = NetworkService()
    let publisher = networkService.createPublisherFor(testSquad)

    cancellable = publisher?.sink { completion in
      switch completion {
      case .finished:
        print("OK")
      case .failure(let error):
        print("Receiving data failed with: \(error.localizedDescription)")
      }
    } receiveValue: { receivedValue in
      print("Received value: \(receivedValue)")
    }
  }

  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
  }


}

