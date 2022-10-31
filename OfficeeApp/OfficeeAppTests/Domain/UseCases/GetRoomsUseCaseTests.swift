//
//  GetRoomsUseCaseTests.swift
//  OfficeeAppTests
//
//  Created by Valeriy L on 30.10.2022.
//

import XCTest
import Officee
@testable import OfficeeApp
import Combine

final class GetRoomsUseCaseTests: XCTestCase {
  private var cancellable: Combine.Cancellable?
  
  override func tearDown() {
    super.tearDown()
    
    cancellable = nil
  }
  
  func test_getEmptyRoomsListWithoutError() {
    let request = RoomsFeedRequest.refreshRequest
    
    let receivedRooms = roomsResult(for: request, with: (nil, []))
    
    XCTAssertEqual(receivedRooms, [])
  }
  
  func test_getListOfTwoRoomsWithoutError() {
    let request = RoomsFeedRequest.refreshRequest
    let rooms = [
      RoomForTestFactory.makeRoom(id: "1").room,
      RoomForTestFactory.makeRoom(id: "2").room
    ]
    
    let receivedRooms = roomsResult(for: request, with: (nil, rooms))
    
    XCTAssertEqual(receivedRooms, rooms)
  }
  
  func test_getRoomsFailsOnError() {
    let request = RoomsFeedRequest.refreshRequest
    let error = EquatableError.anyError
    
    let receivedError = errorResult(for: request, with: (error, [])) as? EquatableError
    
    XCTAssertEqual(receivedError, error)
  }
  
  // MARK: - Helpers
  
  private func errorResult(
    for request: RoomsFeedRequest,
    with data: (error: Error?, rooms: [Room]),
    file: StaticString = #filePath,
    line: UInt = #line
  ) -> Error {
    let result = resultFor(request: request, with: data, file: file, line: line)
    
    switch result {
    case let .success(rooms):
      XCTFail("Expected failure, got \(rooms) instead")
      return EquatableError.anyError
      
    case let .failure(error):
      return error
    }
  }
  
  private func roomsResult(
    for request: RoomsFeedRequest,
    with data: (error: Error?, rooms: [Room]),
    file: StaticString = #filePath,
    line: UInt = #line
  ) -> [Room] {
    let result = resultFor(request: request, with: data, file: file, line: line)
    
    switch result {
    case let .success(rooms):
      return rooms
    case let .failure(error):
      XCTFail("Expected success, got \(error) instead")
      return []
    }
  }
  
  private func resultFor(
    request: RoomsFeedRequest,
    with data: (error: Error?, rooms: [Room]),
    file: StaticString = #filePath,
    line: UInt = #line
  ) -> Swift.Result<[Room], Error> {
    let roomsRepository = RoomsFeedRepositorySpy(error: data.error, rooms: data.rooms)
    let sut = GetRoomsUseCaseImpl(repository: roomsRepository)
    let exp = expectation(description: "Wait for result.")
    
    var receivedResult: Result<[Room], Error>!
    cancellable = sut.invoke(with: request)
      .sink(
        receiveCompletion: { result in
          if case let .failure(error) = result {
            receivedResult = .failure(error)
          }
          exp.fulfill()
        },
        receiveValue: { rooms in
          receivedResult = .success(rooms)
        })
    
    wait(for: [exp], timeout: 1.0)
    
    XCTAssertEqual(roomsRepository.receivedMessages.count, 1)
    
    if case let .getRooms(receivedRequest) = roomsRepository.receivedMessages.first {
      XCTAssertEqual(receivedRequest, request)
    }
    
    return receivedResult
  }
}
