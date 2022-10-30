//
//  RoomsFeedRepository.swift
//  OfficeeAppTests
//
//  Created by Valeriy L on 30.10.2022.
//

import Foundation
import Officee
@testable import OfficeeApp
import Combine

final class RoomsFeedRepositorySpy: RoomsFeedRepository {
  enum ReceivedMessage: Equatable {
    case getPeople(RoomsFeedRequest)
  }
  
  // MARK: - Properties
  
  let error: Error?
  let rooms: [Room]
  private(set) var receivedMessages: [ReceivedMessage] = []
  
  // MARK: - Constructor
  
  init(error: Error?, rooms: [Room]) {
    self.error = error
    self.rooms = rooms
  }
  
  // MARK: - Methods
  
  func getRooms(with request: RoomsFeedRequest) -> AnyPublisher<[Officee.Room], Error> {
    receivedMessages.append(.getPeople(request))
    
    if let error = error {
      return Fail<[Room], Error>(error: error).eraseToAnyPublisher()
    }
    
    return Just(rooms)
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher()
  }
}

struct DummyRoomsFeedRepository: RoomsFeedRepository {
  func getRooms(with request: RoomsFeedRequest) -> AnyPublisher<[Room], Error> {
    Just([])
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher()
  }
}
