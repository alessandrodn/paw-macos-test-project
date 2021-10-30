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
      updateUI()
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
        self?.updateUI()
      }
    }
  }

  @IBAction func deletePreviousRequestClicked(_ sender: NSButton) {
    dataSource?.removeAll()
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
          let selectedRequestData = dataSource?.requestWithTitle(selectedItem) else { return }

    textView?.string = selectedRequestData
  }
}

