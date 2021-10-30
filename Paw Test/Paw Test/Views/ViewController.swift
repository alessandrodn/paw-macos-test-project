//
//  ViewController.swift
//  Paw Test
//
//  Created by Alessandro Di Nepi on 29/10/2021.
//

import Cocoa

class ViewController: NSViewController {

  var requests: [String: String] = [:]

  let data =
    """
    {\n  \"squadName\": \"Super hero squad\",\n  \"homeTown\": \"Metro City\",\n  \"formed\": 2016,\n  \"active\": true,\n  \"members\": [\n    {\n      \"name\": \"Molecule Man\",\n      \"age\": 29,\n      \"secretIdentity\": \"Dan Jukes\",\n      \"powers\": [\n        \"Radiation resistance\",\n        \"Turning tiny\",\n        \"Radiation blast\"\n      ]\n    },\n    {\n      \"name\": \"Madame Uppercut\",\n      \"age\": 39,\n      \"secretIdentity\": \"Jane Wilson\",\n      \"powers\": [\n        \"Million tonne punch\",\n        \"Damage resistance\",\n        \"Superhuman reflexes\"\n      ]\n    },\n    {\n      \"name\": \"Eternal Flame\",\n      \"age\": 1000000,\n      \"secretIdentity\": \"Unknown\",\n      \"powers\": [\n        \"Immortality\",\n        \"Heat Immunity\",\n        \"Inferno\",\n        \"Teleportation\",\n        \"Interdimensional travel\"\n      ]\n    }\n  ]\n}
    """

  @IBOutlet weak var requestsSelectPopUp: NSPopUpButton!
  @IBOutlet weak var scrollView: NSScrollView!

  var textView: NSTextView? { scrollView.documentView as? NSTextView }

  override func viewDidLoad() {
    super.viewDidLoad()
    // TODO: Initialize from the model
    requestsSelectPopUp.removeAllItems()
    updateUI()
  }

  @IBAction func createNewRequestClicked(_ sender: NSButton) {
    // TODO: Send an event to call network
    let request = "Super hero squad - \(Date())"
    requests[request] = data

    // TODO: Call in the completion call of the network
    requestsSelectPopUp.addItem(withTitle: request)
    requestsSelectPopUp.selectItem(withTitle: request)
    updateUI()
  }

  @IBAction func deletePreviousRequestClicked(_ sender: NSButton) {
    // TODO: Remove all previous requests from the model
    requestsSelectPopUp.removeAllItems()
    updateUI()
  }

  @IBAction func requestSelectDidChangeValue(_ sender: NSPopUpButton) {
    updateUI()
  }

  private func updateUI() {
    guard requestsSelectPopUp.numberOfItems > 0 else {
      textView?.string = ""
      return
    }

    guard let selectedItem = requestsSelectPopUp.titleOfSelectedItem,
          let selectedRequestData = requests[selectedItem] else { return }

    textView?.string = selectedRequestData
  }
}

