//
//  LoadFeedsUseCaseTests.swift
//  OfficeeAppTests
//
//  Created by Valeriy L on 30.10.2022.
//

import XCTest
import Officee
@testable import OfficeeApp
import Combine

final class LoadFeedsUseCaseTests: XCTestCase {
  private var cancellable: Combine.Cancellable?
  
  override func tearDown() {
    super.tearDown()
    
    cancellable = nil
  }
  
  func test_LoadFeedUseCasePerformGetEmptyPeopleAndGetEmptyRoomsWithoutErrorOnce() {
    let peopleRepository = PeopleFeedRepositorySpy(error: nil, people: [])
    let roomsRepository = RoomsFeedRepositorySpy(error: nil, rooms: [])
    
    let receivedError = resultError(
      for: peopleRepository,
      rr: roomsRepository)
    
    XCTAssertNil(receivedError)
    XCTAssertEqual(peopleRepository.receivedMessages.count, 1)
    XCTAssertEqual(roomsRepository.receivedMessages.count, 1)
  }
  
  func test_LoadFeedUseCaseReceiveErrorWhileGetPeopleOnce() {
    let error = EquatableError.anyError
    let peopleRepository = PeopleFeedRepositorySpy(error: error, people: [])
    let roomsRepository = DummyRoomsFeedRepository()
    
    let receivedError = resultError(
      for: peopleRepository,
      rr: roomsRepository) as? EquatableError
    
    XCTAssertEqual(receivedError, error)
    XCTAssertEqual(peopleRepository.receivedMessages.count, 1)
  }
  
  func test_LoadFeedUseCaseReceiveErrorWhileGetRooms() {
    let error = EquatableError.anyError
    let peopleRepository = DummyPeopleFeedRepository()
    let roomsRepository = RoomsFeedRepositorySpy(error: error, rooms: [])
    
    let receivedError = resultError(
      for: peopleRepository,
      rr: roomsRepository) as? EquatableError
    
    XCTAssertEqual(receivedError, error)
    XCTAssertEqual(roomsRepository.receivedMessages.count, 1)
  }
  
  // MARK: - Helpers
  
  private func resultError(
    for pr: PeopleFeedRepository,
    rr: RoomsFeedRepository
  ) -> Error? {
    let sut = LoadFeedsUseCaseImpl(peopleRepository: pr, roomsRepository: rr)
    let exp = expectation(description: "Wait for result.")
    
    var receivedError: Error?
    cancellable = sut.invoke()
      .sink(receiveCompletion: { result in
        switch result {
        case let .failure(error):
          receivedError = error
        case .finished:
          break
        }
        exp.fulfill()
      }, receiveValue: { _ in })

    wait(for: [exp], timeout: 1.0)
    
    return receivedError
  }
}
