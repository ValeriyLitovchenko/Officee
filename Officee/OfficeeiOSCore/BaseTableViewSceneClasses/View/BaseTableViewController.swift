//
//  BaseTableViewController.swift
//
//  Created by Valeriy L on 15.09.2022.
//

import UIKit

private struct CellModelContainer: Hashable {
  let cellModel: BaseTableCellModel
  
  func hash(into hasher: inout Hasher) {
    cellModel.hash(into: &hasher)
  }
}

/// Base class for TableView controller
open class BaseTableViewController<View: BaseTableViewControllerView, ViewModel>:
  BaseViewController<View, ViewModel>, UITableViewDelegate, UITableViewDataSource {
  
  // MARK: - Properties
  
  private var content = TableSections()
  
  private lazy var dataSource = UITableViewDiffableDataSource<SectionIdentifier, CellModelContainer>(
    tableView: contentView.tableView, cellProvider: { tableView, indexPath, container in
      BaseTableViewController.cellWith(
        tableView: tableView,
        model: container.cellModel,
        indexPath: indexPath)
  })
  
  // MARK: - Lifecycle
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  // MARK: - Functions
  
  public func display(content: TableSections) {
    self.content = content
    
    var snapshot = NSDiffableDataSourceSnapshot<SectionIdentifier, CellModelContainer>()
    content.forEach { section in
      snapshot.appendSections([section.identifier])
      let items = section.items.map { item in
        CellModelContainer(cellModel: item)
      }
      snapshot.appendItems(items, toSection: section.identifier)
    }
    dataSource.apply(snapshot)
  }
  
  // MARK: - Private functions
  
  private func setupUI() {
    let `view` = contentView
    let tableView = view.tableView
    
    for cell in view.usedCells {
      tableView?.register(cell.nib, forCellReuseIdentifier: cell.identifier)
    }
    
    tableView?.delegate = self
    tableView?.dataSource = self
  }
  
  private static func cellWith(
    tableView: UITableView,
    model: BaseTableCellModel,
    indexPath: IndexPath
  ) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: model.type.identifier,
      for: indexPath) as? BaseTableCell else {
      fatalError("Unable to create cell. Nib might be not registered")
    }
    
    cell.configure(with: model)
    
    return cell
  }
  
  // MARK: - UITableViewDataSource
  
  public final func numberOfSections(in tableView: UITableView) -> Int {
    content.count
  }
  
  public final func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    content[section].items.count
  }
  
  public final func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    BaseTableViewController.cellWith(
      tableView: tableView,
      model: cellModel(for: indexPath),
      indexPath: indexPath)
  }
  
  // MARK: - UITableViewDelegate
    
  open dynamic func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    guard let applicableActionModel = cellModel(for: indexPath) as? ApplicableActionModel else {
      return
    }
    
    applicableActionModel.onAction()
  }
  
  open dynamic func tableView(
    _ tableView: UITableView,
    heightForRowAt indexPath: IndexPath
  ) -> CGFloat {
    cellModel(for: indexPath).cellHeight
  }
  
  public final func tableView(
    _ tableView: UITableView,
    heightForHeaderInSection section: Int
  ) -> CGFloat {
    .leastNormalMagnitude
  }

  public final func tableView(
    _ tableView: UITableView,
    heightForFooterInSection section: Int
  ) -> CGFloat {
    .leastNormalMagnitude
  }
  
  // MARK: - Helpers
  
  final func cellModel(for indexPath: IndexPath) -> BaseTableCellModel {
    content[indexPath.section]
      .items[indexPath.row]
  }
}
