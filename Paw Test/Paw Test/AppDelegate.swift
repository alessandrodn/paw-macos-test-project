//
//  AppDelegate.swift
//  Paw Test
//
//  Created by Alessandro Di Nepi on 29/10/2021.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

  


  func applicationDidFinishLaunching(_ aNotification: Notification) {
    // Insert code here to initialize your application

    let testSquad = SquadGenerator.generateTestSquad()
    print(testSquad)
  }

  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
  }


}

