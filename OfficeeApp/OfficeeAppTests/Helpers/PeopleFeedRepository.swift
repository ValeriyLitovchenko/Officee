//
//  PeopleFeedRepository.swift
//  OfficeeAppTests
//
//  Created by Valeriy L on 30.10.2022.
//

import Foundation
import Officee
@testable import OfficeeApp
import Combine

final class PeopleFeedRepositorySpy: PeopleFeedRepository {
  enum ReceivedMessage: Equatable {
    case getPeople(PeopleFeedRequest)
  }
  
  // MARK: - Properties
  
  let error: Error?
  let people: [Person]
  private(set) var receivedMessages: [ReceivedMessage] = []
  
  // MARK: - Constructor
  
  init(error: Error?, people: [Person]) {
    self.error = error
    self.people = people
  }
  
  // MARK: - Methods
  
  func getPeople(with request: PeopleFeedRequest) -> AnyPublisher<[Person], Error> {
    receivedMessages.append(.getPeople(request))
    
    if let error = error {
      return Fail<[Person], Error>(error: error).eraseToAnyPublisher()
    }
    
    return Just(people)
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher()
  }
}

struct DummyPeopleFeedRepository: PeopleFeedRepository {
  func getPeople(with request: PeopleFeedRequest) -> AnyPublisher<[Person], Error> {
    Just([])
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher()
  }
}
