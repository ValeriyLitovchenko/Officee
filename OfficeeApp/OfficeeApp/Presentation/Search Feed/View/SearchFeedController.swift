//
//  SearchFeedController.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import UIKit
import OfficeeiOSCore
import Combine

enum SearchFeedControllerConstants {
  static let searchBarAnimationDuration = TimeInterval(0.2)
}

class SearchFeedController<View: SearchFeedControllerView>:
  BaseTableViewController<View, SearchFeedViewModel>, UISearchBarDelegate {
  
  // MARK: - Properties
  
  private(set) lazy var keyboardObserver = KeyboardScrollViewObserver(scrollView: contentView.tableView)
  
  private var onSearchBarCancel: VoidCallback?
  private var cancellable: Cancellable?
  
  // MARK: - Constructor
  
  override init(viewModel: SearchFeedViewModel) {
    super.init(viewModel: viewModel)
    title = viewModel.sceneTitle
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    keyboardObserver.startObservation()
    viewModel.loadData()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    view.endEditing(true)
    keyboardObserver.stopObservation()
  }
  
  // MARK: - Functions
  
  func setupUI() {
    let `view` = contentView
    
    title = viewModel.sceneTitle
    
    let refreshControl = UIRefreshControl(
      frame: .zero,
      primaryAction: UIAction(handler: { [viewModel] _ in
        viewModel.reloadData()
      }))
    
    view.tableView.refreshControl = refreshControl
    
    switch viewModel.searchType {
    case .permanent:
      showSearchBar()
      onSearchBarCancel = { [viewModel] in
        viewModel.onCloseScene?()
      }
      
    case .variable:
      addSearchButton()
      onSearchBarCancel = { [weak self] in
        self?.hideSearchBar()
      }
    }
    
    cancellable = viewModel.statePublisher
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] state in
        view.activityIndicator.setIsAnimating(state == .loading)
        view.tableView.refreshControl?.endRefreshing()
        
        guard case let .contentReady(content) = state,
              let self = self else { return }
        
        self.display(content: content)
      })
  }
  
  func hideSearchBar() {
    UIView.animate(
      withDuration: SearchFeedControllerConstants.searchBarAnimationDuration,
      animations: {
        self.navigationItem.titleView = nil
      }, completion: { [weak self] _ in
        self?.addSearchButton()
      })
  }
  
  func addSearchButton() {
    let searchButton = UIBarButtonItem(
      barButtonSystemItem: .search,
      target: self,
      action: #selector(showSearchBar))
    
    navigationItem.setRightBarButton(searchButton, animated: true)
  }
  
  @objc
  func showSearchBar(_ animated: Bool = true) {
    let searchBar = UISearchBar(frame: .zero)
    searchBar.delegate = self
    searchBar.placeholder = viewModel.searchBarPlaceholder
    searchBar.alpha = .zero
    navigationItem.setRightBarButton(nil, animated: true)
    
    UIView.animate(
      withDuration: animated ? SearchFeedControllerConstants.searchBarAnimationDuration : .zero,
      animations: {
        self.navigationItem.titleView = searchBar
        searchBar.alpha = 1.0
      }, completion: { [weak searchBar] _ in
        searchBar?.becomeFirstResponder()
      })
  }
  
  // MARK: - UISearchBarDelegate
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    searchBar.setShowsCancelButton(true, animated: true)
  }
  
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    searchBar.setShowsCancelButton(false, animated: true)
  }
  
  func searchBar(
    _ searchBar: UISearchBar,
    textDidChange searchText: String
  ) {
    viewModel.performSearch(with: searchText)
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.text = nil
    searchBar.resignFirstResponder()
    viewModel.performSearch(with: nil)
    onSearchBarCancel?()
  }
}
