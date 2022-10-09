//
//  SearchFeedViewModel.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import OfficeeiOSCore

protocol SearchFeedViewModel {
  var sceneTitle: String { get }
  var searchBarPlaceholder: String { get }
  var searchType: SearchFeedType { get }
  var statePublisher: ValuePublisher<SearchFeedViewModelState> { get }
  var onCloseScene: VoidCallback? { get set }
  
  func loadData()
  func reloadData()
  func performSearch(with query: String?)
}

typealias SearchFeedViewModelState = CommonTableViewModelState

enum SearchFeedType {
  case variable
  case permanent
}
