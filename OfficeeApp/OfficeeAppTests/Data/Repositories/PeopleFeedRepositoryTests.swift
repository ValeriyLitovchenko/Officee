//
//  PeopleFeedRepositoryTests.swift
//  OfficeeAppTests
//
//  Created by Valeriy L on 30.10.2022.
//

import XCTest
import Officee
@testable import OfficeeApp
import Combine

final class PeopleFeedRepositoryTests: XCTestCase {
  private var cancellable: Combine.Cancellable?
  
  override func tearDown() {
    super.tearDown()
    
    cancellable = nil
  }
  
  func test_getPeopleFailsOnHTTPClientError() {
    let httpClientError = EquatableError.anyError
    let httpClient = HTTPClientSpy(
      error: httpClientError,
      response: nil)
    let request = PeopleFeedRequest.refreshRequest
    let peopleStorage = DummyPeopleFeedStorage()
    
    let receivedError = errorResult(
      httpClient: httpClient,
      peopleStorage: peopleStorage,
      request: request) as? EquatableError
    
    XCTAssertEqual(receivedError, httpClientError)
    XCTAssertEqual(httpClient.urlRequests.count, 1)
  }
  
  func test_getPeopleFailsForAllPeopleStorageErrors() {
    let error = EquatableError.anyError
    XCTAssertNotNil(
      try receiveError_whileGetPeopleWithSuccessEmptyNetworkResponse_forPeopleStorageError(hasStoredPeopleError: error)
    )
    XCTAssertNotNil(
      try receiveError_whileGetPeopleWithSuccessEmptyNetworkResponse_forPeopleStorageError(deleteAllPeopleError: error)
    )
    XCTAssertNotNil(
      try receiveError_whileGetPeopleWithSuccessEmptyNetworkResponse_forPeopleStorageError(savePeopleError: error)
    )
    XCTAssertNotNil(
      try receiveError_whileGetPeopleWithSuccessEmptyNetworkResponse_forPeopleStorageError(getPeopleError: error)
    )
  }
  
  func test_PeopleStorageHasApropriateReceivedMessagesList_forGetPeopleOperationWithoutError() throws {
    let request = PeopleFeedRequest.refreshRequest
    
    let networkResponse = try networkResponse(with: .init())
    let httpClient = HTTPClientSpy(error: nil, response: networkResponse)
    
    let peopleStorage = PeopleFeedStorageSpy(people: [])
    
    let etalonReceivedMessagesList = [
      PeopleFeedStorageSpy.ReceivedMessage.checkStoredPeople,
      .deleteAllPeople,
      .savePeople([]),
      .getPeople(query: request.query)
    ]
    
    peopleResult(
      httpClient: httpClient,
      peopleStorage: peopleStorage,
      request: request)
    
    XCTAssertEqual(peopleStorage.receivedMessages, etalonReceivedMessagesList)
  }
  
  func test_GetPeopleReturnTwoPersons_forSuccessNetworkTwoPersonsResponse() throws {
    let people = [
      PersonForTestFactory.makeLocalPerson(id: "1"),
      PersonForTestFactory.makeLocalPerson(id: "2")
    ]
    
    let request = PeopleFeedRequest.refreshRequest
    
    let networkResponse = try networkResponse(with: people.map(\.json))
    let httpClient = HTTPClientSpy(error: nil, response: networkResponse)
    
    let peopleStorage = PeopleFeedStorageSpy(people: people.map(\.person))
    
    let etalonReceivedMessagesList = [
      PeopleFeedStorageSpy.ReceivedMessage.checkStoredPeople,
      .deleteAllPeople,
      .savePeople([]),
      .getPeople(query: request.query)
    ]
    
  }
  
  // MARK: - Helpers
  
  private func receiveError_whileGetPeopleWithSuccessEmptyNetworkResponse_forPeopleStorageError(
    getPeopleError: Error? = nil,
    hasStoredPeopleError: Error? = nil,
    savePeopleError: Error? = nil,
    deleteAllPeopleError: Error? = nil
  ) throws -> Error? {
    let request = PeopleFeedRequest.refreshRequest
    
    let networkResponse = try networkResponse(with: .init())
    let httpClient = HTTPClientSpy(error: nil, response: networkResponse)
    
    let peopleStorage = PeopleFeedStorageSpy(
      people: [],
      getPeopleError: getPeopleError,
      hasStoredPeopleError: hasStoredPeopleError,
      savePeopleError: savePeopleError,
      deleteAllPeopleError: deleteAllPeopleError)
    
    let result = resultFor(
      httpClient: httpClient,
      peopleStorage: peopleStorage,
      request: request)
    
    switch result {
    case let .success(people):
      XCTFail("Expected failure, got \(people) instead")
      return nil
      
    case let .failure(error):
      return error
    }
  }
  
  @discardableResult
  private func errorResult(
    httpClient: HTTPClient,
    peopleStorage: PeopleFeedStorage,
    request: PeopleFeedRequest
  ) -> Error {
    let result = resultFor(
      httpClient: httpClient,
      peopleStorage: peopleStorage,
      request: request)
    
    switch result {
    case let .success(people):
      XCTFail("Expected failure, got \(people) instead")
      return EquatableError.anyError
      
    case let .failure(error):
      return error
    }
  }
  
  @discardableResult
  private func peopleResult(
    httpClient: HTTPClient,
    peopleStorage: PeopleFeedStorage,
    request: PeopleFeedRequest
  ) -> [Person] {
    let result = resultFor(
      httpClient: httpClient,
      peopleStorage: peopleStorage,
      request: request)
    
    switch result {
    case let .success(people):
      return people
    case let .failure(error):
      XCTFail("Expected success, got \(error) instead")
      return []
    }
  }
  
  private func resultFor(
    httpClient: HTTPClient,
    peopleStorage: PeopleFeedStorage,
    request: PeopleFeedRequest
  ) -> Swift.Result<[Person], Error> {
    let sut = makeSUT(httpClient: httpClient, peopleStorage: peopleStorage)
    let exp = expectation(description: "Waiting for result.")
    
    var result: Swift.Result<[Person], Error>!
    cancellable = sut.getPeople(with: request)
      .sink(
        receiveCompletion: { r in
          if case let .failure(error) = r {
            result = .failure(error)
          }
          exp.fulfill()
        },
        receiveValue: { people in
          result = .success(people)
        })
    
    wait(for: [exp], timeout: 1.0)
    
    return result
  }
  
  private func makeSUT(
    httpClient: HTTPClient,
    peopleStorage: PeopleFeedStorage
  ) -> PeopleFeedRepository {
    PeopleFeedRepositoryImpl(
      httpClient: httpClient,
      urlRequestFactory: URLRequestFactoryImpl(url: appleURL),
      peopleStorage: peopleStorage)
  }
}
