//
//  ViewController.swift
//  Paw Test
//
//  Created by Alessandro Di Nepi on 29/10/2021.
//

import Cocoa

protocol RequestDataSource: AnyObject {
  func generateNewRequest(_ completion: @escaping (String) -> Void)
  func requestWithTitle(_ title: String) -> String?
  func getAll() -> [String]
  func removeAll()
}

class ViewController: NSViewController {
  // This can be implemented reactively with a Combine pipeline
  var dataSource: RequestDataSource? {
    didSet {
      guard let dataSource = dataSource else { return }

      requestsSelectPopUp.removeAllItems()
      requestsSelectPopUp.addItems(withTitles: dataSource.getAll())
      updateView()
    }
  }

  @IBOutlet private weak var requestsSelectPopUp: NSPopUpButton!
  @IBOutlet private weak var scrollView: NSScrollView!
  private var textView: NSTextView? { scrollView.documentView as? NSTextView }

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func createNewRequestClicked(_ sender: NSButton) {
    dataSource?.generateNewRequest { newTitle in
      DispatchQueue.main.async { [weak self] in
        self?.requestsSelectPopUp.addItem(withTitle: newTitle)
        self?.requestsSelectPopUp.selectItem(withTitle: newTitle)
        self?.updateView()
      }
    }
  }

  @IBAction func deletePreviousRequestClicked(_ sender: NSButton) {
    dataSource?.removeAll()
    requestsSelectPopUp.removeAllItems()
    updateView()
  }

  @IBAction func requestSelectDidChangeValue(_ sender: NSPopUpButton) {
    updateView()
  }

  private func updateView() {
    guard requestsSelectPopUp.numberOfItems > 0 else {
      textView?.string = ""
      return
    }

    guard let selectedItem = requestsSelectPopUp.titleOfSelectedItem,
          let responseData = dataSource?.requestWithTitle(selectedItem) else { return }

    textView?.string = format(responseData: responseData)
  }

  // TODO: Remove this and display the JSON tree with a NSDocumentView
  private func format(responseData: String) -> String {
    let json = try! JSONDecoder().decode(Squad.self, from: responseData.data(using: .utf8) ?? Data())

    let jsonEncoder = JSONEncoder()
    jsonEncoder.outputFormatting = .prettyPrinted
    let parsedString = try! jsonEncoder.encode(json)
    return String(data: parsedString, encoding: .utf8)!
  }
}

