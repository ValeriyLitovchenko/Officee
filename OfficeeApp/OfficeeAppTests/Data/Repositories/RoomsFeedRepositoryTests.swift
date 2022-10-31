//
//  RoomsFeedRepositoryTests.swift
//  OfficeeAppTests
//
//  Created by Valeriy L on 31.10.2022.
//

import XCTest
import Officee
@testable import OfficeeApp
import Combine

final class RoomsFeedRepositoryTests: XCTestCase {
  private var cancellable: Combine.Cancellable?
  
  override func tearDown() {
    super.tearDown()
    
    cancellable = nil
  }
  
  func test_getRoomsFailOnHTTPClientError() {
    let httpClientError = EquatableError.anyError
    let httpClient = HTTPClientSpy(
      error: httpClientError,
      response: nil)
    let request = RoomsFeedRequest.refreshRequest
    let roomsStorage = DummyRoomsFeedStorage()
    
    let receivedError = errorResult(
      httpClient: httpClient,
      roomsStorage: roomsStorage,
      request: request) as? EquatableError
    
    XCTAssertEqual(receivedError, httpClientError)
    XCTAssertEqual(httpClient.urlRequests.count, 1)
  }
  
  func test_getRoomsFailsForAllRoomsStorageErrors() throws {
    let error = EquatableError.anyError
    XCTAssertNotNil(
      try receiveError_whileGetRoomsWithSuccessEmptyNetworkResponse_forRoomsStorageError(hasStoredRoomsError: error)
    )
    XCTAssertNotNil(
      try receiveError_whileGetRoomsWithSuccessEmptyNetworkResponse_forRoomsStorageError(deleteAllRoomsError: error)
    )
    XCTAssertNotNil(
      try receiveError_whileGetRoomsWithSuccessEmptyNetworkResponse_forRoomsStorageError(saveRoomsError: error)
    )
    XCTAssertNotNil(
      try receiveError_whileGetRoomsWithSuccessEmptyNetworkResponse_forRoomsStorageError(getRoomsError: error)
    )
  }
  
  func test_RoomsStorageHasAppropriateReceivedMessageList_forGetRoomsOperationWithoutError() throws {
    let request = RoomsFeedRequest.refreshRequest
    
    let networkResponse = try networkResponse(with: .init())
    let httpClient = HTTPClientSpy(error: nil, response: networkResponse)
    
    let roomsStorage = RoomsFeedStorageSpy(rooms: [])
    
    let etalonReceivedMessagesList = [
      RoomsFeedStorageSpy.ReceivedMessage.checkStoredRooms,
      .deleteAllRooms,
      .saveRooms([]),
      .getRooms(query: request.query)
    ]
    
    roomsResult(
      httpClient: httpClient,
      roomsStorage: roomsStorage,
      request: request)
    
    XCTAssertEqual(roomsStorage.receivedMessages, etalonReceivedMessagesList)
  }
  
  func test_GetRoomsReturnTwoRooms_forSuccessNetworkTwoRoomsResponse() throws {
    let rooms = [
      RoomForTestFactory.makeLocalRoom(id: "1"),
      RoomForTestFactory.makeLocalRoom(id: "2")
    ]
    
    let request = RoomsFeedRequest.refreshRequest
    
    let networkResponse = try networkResponse(with: rooms.map(\.json))
    let httpClient = HTTPClientSpy(error: nil, response: networkResponse)
    
    let roomsStorage = RoomsFeedStorageSpy(rooms: rooms.map(\.room))
    
    let roomsResult = roomsResult(
      httpClient: httpClient,
      roomsStorage: roomsStorage,
      request: request)
    
    XCTAssertEqual(roomsResult, rooms.map(\.room).map(\.toDomain))
  }
  
  // MARK: - Helpers
  
  private func receiveError_whileGetRoomsWithSuccessEmptyNetworkResponse_forRoomsStorageError(
    getRoomsError: Error? = nil,
    hasStoredRoomsError: Error? = nil,
    saveRoomsError: Error? = nil,
    deleteAllRoomsError: Error? = nil
  ) throws -> Error? {
    let request = RoomsFeedRequest.refreshRequest
    
    let networkResponse = try networkResponse(with: .init())
    let httpClient = HTTPClientSpy(error: nil, response: networkResponse)
    
    let roomsStorage = RoomsFeedStorageSpy(
      rooms: [],
      getRoomsError: getRoomsError,
      hasStoredRoomsError: hasStoredRoomsError,
      saveRoomsError: saveRoomsError,
      deleteAllRoomsError: deleteAllRoomsError
    )
    
    let result = resultFor(
      httpClient: httpClient,
      roomsStorage: roomsStorage,
      request: request)
    
    switch result {
    case let .success(rooms):
      XCTFail("Expected failure, got \(rooms) instead")
      return nil
      
    case let .failure(error):
      return error
    }
  }
  
  @discardableResult
  private func errorResult(
    httpClient: HTTPClient,
    roomsStorage: RoomsFeedStorage,
    request: RoomsFeedRequest
  ) -> Error {
    let result = resultFor(
      httpClient: httpClient,
      roomsStorage: roomsStorage,
      request: request)
    
    switch result {
    case let .success(rooms):
      XCTFail("Expected failure, got \(rooms) instead")
      return EquatableError.anyError
      
    case let .failure(error):
      return error
    }
  }
  
  @discardableResult
  private func roomsResult(
    httpClient: HTTPClient,
    roomsStorage: RoomsFeedStorage,
    request: RoomsFeedRequest
  ) -> [Room] {
    let result = resultFor(
      httpClient: httpClient,
      roomsStorage: roomsStorage,
      request: request)
    
    switch result {
    case let .success(rooms):
      return rooms
    case let .failure(error):
      XCTFail("Expected success, got \(error) instead")
      return []
    }
  }
  
  private func resultFor(
    httpClient: HTTPClient,
    roomsStorage: RoomsFeedStorage,
    request: RoomsFeedRequest
  ) -> Swift.Result<[Room], Error> {
    let sut = makeSUT(
      httpClient: httpClient,
      roomsStorage: roomsStorage)
    let exp = expectation(description: "Waiting for result.")
    
    var result: Swift.Result<[Room], Error>!
    cancellable = sut.getRooms(with: request)
      .sink(
        receiveCompletion: { r in
          if case let .failure(error) = r {
            result = .failure(error)
          }
          exp.fulfill()
        },
        receiveValue: { rooms in
          result = .success(rooms)
        })
    
    wait(for: [exp], timeout: 1.0)
    
    return result
  }
  
  private func makeSUT(
    httpClient: HTTPClient,
    roomsStorage: RoomsFeedStorage
  ) -> RoomsFeedRepository {
    RoomsFeedRepositoryImpl(
      httpClient: httpClient,
      urlRequestFactory: URLRequestFactoryImpl(url: appleURL),
      roomsStorage: roomsStorage)
  }
}
