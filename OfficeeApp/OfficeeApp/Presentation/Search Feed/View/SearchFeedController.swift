//
//  SearchFeedController.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import UIKit
import OfficeeiOSCore
import Combine

final class SearchFeedController: BaseTableViewController<SearchFeedControllerView, SearchFeedViewModel> {
  
  private enum Constants {
    static let searchBarAnimationDuration = TimeInterval(0.2)
  }
  
  // MARK: - Properties
  
  private lazy var keyboardObserver = KeyboardScrollViewObserver(scrollView: contentView.tableView)
  
  private var onSearchBarCancel: VoidCallback?
  private var cancellable: Cancellable?
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    keyboardObserver.startObservation()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    view.endEditing(true)
    keyboardObserver.stopObservation()
  }
  
  // MARK: - Private Functions
  
  private func setupUI() {
    let `view` = contentView
    
    title = viewModel.sceneTitle
    
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
        
        guard case let .contentReady(content) = state,
              let self = self else { return }
        
        self.display(content: content)
      })
  }
  
  private func hideSearchBar() {
    UIView.animate(
      withDuration: Constants.searchBarAnimationDuration,
      animations: {
        self.navigationItem.titleView = nil
      }, completion: { [weak self] _ in
        self?.addSearchButton()
      })
  }
  
  private func addSearchButton() {
    let searchButton = UIBarButtonItem(
      barButtonSystemItem: .search,
      target: self,
      action: #selector(showSearchBar))
    
    navigationItem.setRightBarButton(searchButton, animated: true)
  }
  
  @objc
  private func showSearchBar(_ animated: Bool = true) {
    let searchBar = UISearchBar(frame: .zero)
    searchBar.delegate = self
    searchBar.placeholder = viewModel.searchBarPlaceholder
    searchBar.alpha = .zero
    navigationItem.setRightBarButton(nil, animated: true)
    
    UIView.animate(
      withDuration: animated ? Constants.searchBarAnimationDuration : .zero,
      animations: {
        self.navigationItem.titleView = searchBar
        searchBar.alpha = 1.0
      }, completion: { [weak searchBar] _ in
        searchBar?.becomeFirstResponder()
      })
  }
}

// MARK: - UISearchBarDelegate

extension SearchFeedController: UISearchBarDelegate {
  
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
    viewModel.performSearch(with: searchText.nilIfEmpty)
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
