//
//  PeopleFeedRepositoryImpl.swift
//  OfficeeApp
//
//  Created by Valeriy L on 08.10.2022.
//

import Officee
import Combine

final class PeopleFeedRepositoryImpl: PeopleFeedRepository {
  
  // MARK: - Properties
  
  private let httpClient: HTTPClient
  private let urlRequestFactory: URLRequestFactory
  private let peopleStorage: PeopleFeedStorage
  
  // MARK: - Constructor
  
  init(
    httpClient: HTTPClient,
    urlRequestFactory: URLRequestFactory,
    peopleStorage: PeopleFeedStorage
  ) {
    self.httpClient = httpClient
    self.urlRequestFactory = urlRequestFactory
    self.peopleStorage = peopleStorage
  }
  
  // MARK: - Functions
  
  func getPeople(with request: PeopleFeedRequest) -> AnyPublisher<[Person], Error> {
    Just(request)
      .tryMap { [peopleStorage] request in
        !(try peopleStorage.hasStoredPeople()) || request.shouldRefresh
      }
      .flatMap { [weak self] shouldRefresh -> AnyPublisher<[Person], Error> in
        guard shouldRefresh, let self = self else {
          return JustAnyPublisher(.init())
        }
        
        return self.getPeopleFromNetworkAndStore()
      }
      .tryMap { [peopleStorage, request] _ in
        try peopleStorage.getPeople(for: request.query)
      }
      .map { $0.toDomain() }
      .eraseToAnyPublisher()
  }
  
  // MARK: - Private Functions
  
  private func getPeopleFromNetworkAndStore() -> AnyPublisher<[Person], Error> {
    getPeopleFromNetwork()
      .handleResult { [peopleStorage] people in
        try peopleStorage.deleteAllPeople()
        try peopleStorage.save(people: people.toLocalPeople())
      }
  }
  
  private func getPeopleFromNetwork() -> AnyPublisher<[Person], Error> {
    let apiEndpoint = PeopleFeedApiEndpoint.getPeople
    let request = urlRequestFactory.requestFor(api: apiEndpoint)
    
    return httpClient.getPublisher(from: request)
      .tryMap(HTTPURLResponseDataMapper.map)
      .tryMap(PeopleFeedResultMapper.map)
      .eraseToAnyPublisher()
  }
}

private extension Array where Element == Person {
  func toLocalPeople() -> [LocalPerson] {
    map(\.toLocalPerson)
  }
}

private extension Array where Element == LocalPerson {
  func toDomain() -> [Person] {
    map(\.toDomain)
  }
}
