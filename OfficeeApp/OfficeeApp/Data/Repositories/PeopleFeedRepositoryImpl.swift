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
  
  private let networkService: NetworkService
  private let peopleStorage: PeopleFeedStorage
  
  // MARK: - Constructor
  
  init(
    networkService: NetworkService,
    peopleStorage: PeopleFeedStorage
  ) {
    self.networkService = networkService
    self.peopleStorage = peopleStorage
  }
  
  // MARK: - Functions
  
  func getPeople(with request: PeopleFeedRequest) -> AnyPublisher<[Person], Error> {
    Just(request)
      .flatMap { [weak self] request -> AnyPublisher<[Person], Error> in
        guard let self = self else {
          return Empty<[Person], Error>().eraseToAnyPublisher()
        }
        
        let hasStoredPeople = (try? self.peopleStorage.hasStoredPeople()) ?? false
        guard request.shouldRefresh
                || (hasStoredPeople == false) else {
          return Just([Person]())
            .setFailureType(to: Swift.Error.self)
            .eraseToAnyPublisher()
        }
        
        return self.getPeopleFromNetworkAndStore()
      }
      .flatMap { [weak self] _ -> AnyPublisher<[Person], Error> in
        guard let self = self else {
          return Empty<[Person], Error>().eraseToAnyPublisher()
        }
        
        return self.getPeopleFromStorage(with: request.query)
      }
      .eraseToAnyPublisher()
  }
  
  // MARK: - Private Functions
  
  private func getPeopleFromNetworkAndStore() -> AnyPublisher<[Person], Error> {
    getPeopleFromNetwork()
      .handleEvents(receiveOutput: { [peopleStorage] people in
        try? peopleStorage.deleteAllPeople()
        try? peopleStorage.save(people: people.toLocalPeople())
      })
      .eraseToAnyPublisher()
  }
  
  private func getPeopleFromNetwork() -> AnyPublisher<[Person], Error> {
    let apiEndpoint = PeopleFeedApiEndpoint.getPeople
    return networkService.getPublisher(from: apiEndpoint.urlRequest(baseURL:))
      .tryMap(HTTPURLResponseDataMapper.map)
      .tryMap(PeopleFeedResultMapper.map)
      .retry(2)
      .eraseToAnyPublisher()
  }
  
  private func getPeopleFromStorage(with query: String?) -> AnyPublisher<[Person], Error> {
    Deferred { [peopleStorage] in
      Future { promise in
        promise(Result {
          try peopleStorage.getPeople(for: query)
        })
      }
    }
    .map { $0.toDomain() }
    .eraseToAnyPublisher()
  }
}

private extension Array where Element == Person {
  func toLocalPeople() -> [LocalPerson] {
    map { person in
      LocalPerson(
        id: person.id,
        firstName: person.firstName,
        lastName: person.lastName,
        avatar: person.avatar,
        email: person.email,
        jobTitle: person.jobTitle,
        favoriteColor: person.favoriteColor,
        meetingDescription: person.meetingDescription)
    }
  }
}

private extension Array where Element == LocalPerson {
  func toDomain() -> [Person] {
    map { person in
      Person(
        id: person.id,
        firstName: person.firstName,
        lastName: person.lastName,
        avatar: person.avatar,
        email: person.email,
        jobTitle: person.jobTitle,
        favoriteColor: person.favoriteColor,
        meetingDescription: person.meetingDescription)
    }
  }
}
