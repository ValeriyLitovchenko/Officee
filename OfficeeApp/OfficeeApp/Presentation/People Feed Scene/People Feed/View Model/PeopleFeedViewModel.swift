//
//  PeopleFeedViewModel.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import Foundation
import Officee
import OfficeeiOSCore
import Combine

final class PeopleFeedViewModel: SearchFeedViewModel {
  private typealias PeopleFeedOperation = AnyPublisher<[Person], Error>
  
  private enum Constants {
    static let searchOperationDelay = RunLoop.SchedulerTimeType.Stride(0.18)
    static let peopleSectionIdentifier = "people_section"
  }
  
  // MARK: - Properties
  
  let sceneTitle = NSLocalizedString("People", comment: "")
  let searchBarPlaceholder = NSLocalizedString("Enter person name", comment: "")
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
  
  private let getPeopleUseCase: GetPeopleUseCase
  
  // MARK: - Constructor
  
  init(getPeopleUseCase: GetPeopleUseCase) {
    self.getPeopleUseCase = getPeopleUseCase
    
    publishersCancellable = Publishers.CombineLatest(
      refreshDataSubject.eraseToAnyPublisher(),
      searchQuerySubject.eraseToAnyPublisher()
    )
    .map { [getPeopleUseCase] shouldRefresh, searchQuery in
      PeopleFeedViewModel.setupFeedOperation(
        with: searchQuery,
        shouldRefresh: shouldRefresh,
        getPeopleUseCase: getPeopleUseCase)
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
  
  private func perform(feedOperation: PeopleFeedOperation) {
    queryCancellable?.cancel()
    
    queryCancellable = feedOperation
      .map { [weak self] people in
        self?.buildContent(people) ?? []
      }
      .receive(on: DispatchQueue.main)
      .handleEvents(receiveSubscription: { [weak self] _ in
        self?.stateSubject.send(.loading)
      })
      .sink(receiveCompletion: { [weak self] completion in
        guard let self = self else { return }
        
        switch completion {
        case .finished:
          self.stateSubject.send(.dataLoaded)
          
        case let .failure(error):
          self.stateSubject.send(.error(error))
        }
      }, receiveValue: { [weak self] content in
        self?.stateSubject.send(.contentReady(content))
      })
  }
  
  private static func setupFeedOperation(
    with query: String?,
    shouldRefresh: Bool,
    getPeopleUseCase: GetPeopleUseCase
  ) -> PeopleFeedOperation {
    if let query = query?.nilIfEmpty {
      return Deferred {
          Just(PeopleFeedRequest(query: query, shouldRefresh: shouldRefresh))
            .setFailureType(to: Error.self)
        }
        .delay(
          for: PeopleFeedViewModel.Constants.searchOperationDelay,
          scheduler: RunLoop.main)
        .eraseToAnyPublisher()
        .flatMap { [getPeopleUseCase] request in
          getPeopleUseCase.invoke(with: request)
        }
        .eraseToAnyPublisher()
    } else {
      return getPeopleUseCase
        .invoke(with: PeopleFeedRequest(shouldRefresh: shouldRefresh))
    }
  }
  
  private func buildContent(_ people: [Person]) -> TableSections {
    var items: [BaseTableCellModel] = [
      SpacingCellModel(height: 10.0)
    ]
    
    if people.isEmpty {
      items.append(SearchFeedNoResultsCellModel())
    } else {
      people.forEach { person in
        let model = PersonCellModel(
          identifier: person.id,
          fullName: person.fullName,
          avatar: person.avatar,
          meetingDescription: person.meetingDescription)
        items.append(model)
        items.append(SpacingCellModel(height: 10.0))
      }
    }
    
    return [
      TableSectionModel(
        identifier: PeopleFeedViewModel.Constants.peopleSectionIdentifier,
        items: items)
    ]
  }
}
