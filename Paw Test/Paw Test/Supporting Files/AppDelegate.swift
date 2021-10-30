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
    if let rootViewController = NSApp.windows.first?.contentViewController as? ViewController {
      rootViewController.dataSource = RequestDataStore(networkService: NetworkService())
    }
  }

  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
  }


}

