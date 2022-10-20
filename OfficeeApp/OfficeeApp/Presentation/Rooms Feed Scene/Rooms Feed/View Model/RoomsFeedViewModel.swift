//
//  RoomsFeedViewModel.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import Foundation
import Officee
import OfficeeiOSCore
import Combine

final class RoomsFeedViewModel: SearchFeedViewModel {
  private typealias RoomsFeedOperation = AnyPublisher<[Room], Error>
  
  private enum Constants {
    static let searchOperationDelay = RunLoop.SchedulerTimeType.Stride(0.18)
    static let roomsSectionIdentifier = "rooms_section"
  }
  
  // MARK: - Properties
  
  let sceneTitle = NSLocalizedString("Rooms", comment: "")
  let searchBarPlaceholder = NSLocalizedString("Enter room number", comment: "")
  let searchType = SearchFeedType.variable
  
  var statePublisher: ValuePublisher<SearchFeedViewModelState> {
    stateSubject.eraseToAnyPublisher()
  }
  private let stateSubject = ValueSubject<SearchFeedViewModelState>(.initial)
  
  var onCloseScene: VoidCallback?
  
  private let refreshDataSubject = ValueSubject<Bool>(false)
  private let searchQuerySubject = ValueSubject<String?>(nil)
  private var publishersCancellable: Combine.Cancellable?
  private var queryCancellable: Combine.Cancellable?
  
  private let getRoomsUseCase: GetRoomsUseCase
  private let navigationActions: RoomsFeedNavigationActions
  
  // MARK: - Constructor
  
  init(
    getRoomsUseCase: GetRoomsUseCase,
    navigationActions: RoomsFeedNavigationActions
  ) {
    self.getRoomsUseCase = getRoomsUseCase
    self.navigationActions = navigationActions
    
    publishersCancellable = Publishers.CombineLatest(
      refreshDataSubject.eraseToAnyPublisher(),
      searchQuerySubject.eraseToAnyPublisher()
    )
    .map { [getRoomsUseCase] shouldRefresh, searchQuery in
      RoomsFeedViewModel.setupFeedOperation(
        with: searchQuery,
        shouldRefresh: shouldRefresh,
        getRoomsUseCase: getRoomsUseCase)
    }
    .sink(receiveValue: { [weak self] feedOperation in
      self?.perform(feedOperation: feedOperation)
    })
  }
  
  // MARK: - Functions
  
  func loadData() {
    refreshDataSubject.send(false)
  }
  
  func reloadData() {
    refreshDataSubject.send(true)
  }
  
  func performSearch(with query: String?) {
    refreshDataSubject.send(false)
    searchQuerySubject.send(query)
  }
  
  // MARK: - Private Functions
  
  private func perform(feedOperation: RoomsFeedOperation) {
    queryCancellable?.cancel()
    
    queryCancellable = feedOperation
      .map { [weak self] rooms in
        self?.buildContent(rooms) ?? []
      }
      .dispatchOnMainQueue()
      .add(operationStatePublisher: stateSubject.statePublisher)
      .sink(receiveCompletion: { [navigationActions] completion in
        guard case let .failure(error) = completion else { return }
        
        navigationActions.showToastMessage(error.localizedDescription)
      }, receiveValue: { [stateSubject] content in
        stateSubject.send(.contentReady(content))
      })
  }
  
  private static func setupFeedOperation(
    with query: String?,
    shouldRefresh: Bool,
    getRoomsUseCase: GetRoomsUseCase
  ) -> RoomsFeedOperation {
    if let query = query?.nilIfEmpty {
      return Deferred {
          Just(RoomsFeedRequest(query: query, shouldRefresh: shouldRefresh))
            .setFailureType(to: Error.self)
        }
        .delay(
          for: RoomsFeedViewModel.Constants.searchOperationDelay,
          scheduler: RunLoop.main)
        .eraseToAnyPublisher()
        .flatMap { [getRoomsUseCase] request in
          getRoomsUseCase.invoke(with: request)
        }
        .eraseToAnyPublisher()
    } else {
      return getRoomsUseCase
        .invoke(with: RoomsFeedRequest(shouldRefresh: shouldRefresh))
    }
  }
  
  private func buildContent(_ rooms: [Room]) -> TableSections {
    var items: [BaseTableCellModel] = [
      SpacingCellModel(height: 20.0)
    ]
    
    if rooms.isEmpty {
      items.append(SearchFeedNoResultsCellModel())
    } else {
      rooms.forEach { room in
        let model = RoomCellModel(
          identifier: room.id,
          name: "\(NSLocalizedString("Room", comment: "")) \(room.name)",
          isOccupied: room.isOccupied,
          maxOccupancy: "\(NSLocalizedString("Maximum:", comment: "")) \(room.maxOccupancy)")
        items.append(model)
        items.append(SpacingCellModel(height: 10.0))
      }
    }
    
    return [
      TableSectionModel(
        identifier: RoomsFeedViewModel.Constants.roomsSectionIdentifier,
        items: items)
    ]
  }
}
