//
//  GetPeopleUseCaseTests.swift
//  OfficeeAppTests
//
//  Created by Valeriy L on 30.10.2022.
//

import XCTest
import Officee
@testable import OfficeeApp
import Combine

final class GetPeopleUseCaseTests: XCTestCase {
  private var cancellable: Combine.Cancellable?
  
  override func tearDown() {
    super.tearDown()
    
    cancellable = nil
  }
  
  func test_getEmptyPeopleListWithoutError() {
    let request = PeopleFeedRequest.refreshRequest
    
    let receivedPeople = peopleResult(for: request, with: (nil, []))
    
    XCTAssertEqual(receivedPeople, [])
  }
  
  func test_getListOfTwoPersonsWithoutError() {
    let request = PeopleFeedRequest.refreshRequest
    let people = [
      PersonForTestFactory.makePerson(id: "1").person,
      PersonForTestFactory.makePerson(id: "2").person
    ]
    
    let receivedPeople = peopleResult(for: request, with: (nil, people))
    
    XCTAssertEqual(receivedPeople, people)
  }
  
  func test_getPeopleFailsOnError() {
    let request = PeopleFeedRequest.refreshRequest
    let error = EquatableError.anyError
    
    let receivedError = errorResult(for: request, with: (error, [])) as? EquatableError
    
    XCTAssertEqual(receivedError, error)
  }
  
  // MARK: - Helpers
  
  private func errorResult(
    for request: PeopleFeedRequest,
    with data: (error: Error?, people: [Person]),
    file: StaticString = #filePath,
    line: UInt = #line
  ) -> Error {
    let result = resultFor(request: request, with: data, file: file, line: line)
    
    switch result {
    case let .success(people):
      XCTFail("Expected failure, got \(people) instead")
      return EquatableError.anyError
      
    case let .failure(error):
      return error
    }
  }
  
  private func peopleResult(
    for request: PeopleFeedRequest,
    with data: (error: Error?, people: [Person]),
    file: StaticString = #filePath,
    line: UInt = #line
  ) -> [Person] {
    let result = resultFor(request: request, with: data, file: file, line: line)
    
    switch result {
    case let .success(people):
      return people
    case let .failure(error):
      XCTFail("Expected success, got \(error) instead")
      return []
    }
  }
  
  private func resultFor(
    request: PeopleFeedRequest,
    with data: (error: Error?, people: [Person]),
    file: StaticString = #filePath,
    line: UInt = #line
  ) -> Swift.Result<[Person], Error> {
    let peopleRepository = PeopleFeedRepositorySpy(error: data.error, people: data.people)
    let sut = GetPeopleUseCaseImpl(repository: peopleRepository)
    let exp = expectation(description: "Wait for result.")
    
    var receivedResult: Result<[Person], Error>!
    cancellable = sut.invoke(with: request)
      .sink(
        receiveCompletion: { result in
          if case let .failure(error) = result {
            receivedResult = .failure(error)
          }
          exp.fulfill()
        },
        receiveValue: { people in
          receivedResult = .success(people)
        })
    
    wait(for: [exp], timeout: 1.0)
    
    XCTAssertEqual(peopleRepository.receivedMessages.count, 1)
    
    if case let .getPeople(receivedRequest) = peopleRepository.receivedMessages.first {
      XCTAssertEqual(receivedRequest, request)
    }
    
    return receivedResult
  }
}
