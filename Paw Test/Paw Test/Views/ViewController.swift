//
//  ViewController.swift
//  Paw Test
//
//  Created by Alessandro Di Nepi on 29/10/2021.
//

import Cocoa

protocol RequestDataSource: AnyObject {
  func generateNewRequest(_ completion: @escaping (Result<String, Error>) -> Void)
  func requestWithTitle(_ title: String) -> TreeNode?
  func getAllTitles() -> [String]
  func removeAll()
}

class ViewController: NSViewController {
  // This can be implemented reactively with a Combine pipeline
  var dataSource: RequestDataSource? {
    didSet {
      guard let dataSource = dataSource else { return }

      requestsSelectPopUp.removeAllItems()
      requestsSelectPopUp.addItems(withTitles: dataSource.getAllTitles())
      updateView()
    }
  }

  @IBOutlet private weak var requestsSelectPopUp: NSPopUpButton!
  @IBOutlet private weak var outlineView: NSOutlineView!

  private lazy var treeController: NSTreeController = {
    let treeController = NSTreeController()
    treeController.objectClass = TreeNode.self
    treeController.childrenKeyPath = "children"
    treeController.countKeyPath = "count"
    treeController.leafKeyPath = "isLeaf"

    return treeController
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    outlineView.delegate = self
    outlineView.expandItem(nil, expandChildren: true)

    bind()
  }

  private func bind() {
    outlineView.bind(NSBindingName(rawValue: "content"),
                     to: treeController,
                     withKeyPath: "arrangedObjects",
                     options: nil)
  }

  @IBAction func createNewRequestClicked(_ sender: NSButton) {
    dataSource?.generateNewRequest { result in
      DispatchQueue.main.async { [weak self] in
        switch result {
        case .success(let newTitle):
          self?.requestsSelectPopUp.addItem(withTitle: newTitle)
          self?.requestsSelectPopUp.selectItem(withTitle: newTitle)
          self?.updateView()
        case .failure(let error):
          // TODO: Display error
          print("Error: \(error.localizedDescription)")
        }
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
      treeController.content = []
      return
    }

    guard let selectedItem = requestsSelectPopUp.titleOfSelectedItem,
          let rootNode = dataSource?.requestWithTitle(selectedItem) else { return }

    treeController.content = rootNode.children
    outlineView.expandItem(nil, expandChildren: true)
  }
}

extension ViewController: NSOutlineViewDelegate {
  func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
    var cellView: NSTableCellView?

    guard let cellIdentifier = tableColumn?.identifier else { return nil }

    switch cellIdentifier {
    case .init("key"):
      if let view = outlineView.makeView(withIdentifier: cellIdentifier, owner: outlineView.delegate) as? NSTableCellView {
        view.textField?.bind(.value, to: view, withKeyPath: "objectValue.title", options: nil)
        cellView = view
      }
    case .init("value"):
      if let view = outlineView.makeView(withIdentifier: cellIdentifier, owner: outlineView.delegate) as? NSTableCellView {
        view.textField?.bind(.value, to: view, withKeyPath: "objectValue.countOrValue", options: nil)
        cellView = view
      }
    default:
      break
    }

    return cellView
  }
}
