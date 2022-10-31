//
//  PeopleFeedStorage.swift
//  OfficeeAppTests
//
//  Created by Valeriy L on 30.10.2022.
//

import Foundation
import Officee

final class PeopleFeedStorageSpy: PeopleFeedStorage {
  enum ReceivedMessage: Equatable {
    case getPeople(query: String?)
    case checkStoredPeople
    case savePeople([Officee.LocalPerson])
    case deleteAllPeople
  }
  
  // MARK: - Properties
  
  let people: [Officee.LocalPerson]
  let getPeopleError: Error?
  let hasStoredPeopleError: Error?
  let savePeopleError: Error?
  let deleteAllPeopleError: Error?
  private(set) var receivedMessages = [ReceivedMessage]()
  
  // MARK: - Constructor
  
  init(
    people: [Officee.LocalPerson],
    getPeopleError: Error? = nil,
    hasStoredPeopleError: Error? = nil,
    savePeopleError: Error? = nil,
    deleteAllPeopleError: Error? = nil
  ) {
    self.people = people
    self.getPeopleError = getPeopleError
    self.hasStoredPeopleError = hasStoredPeopleError
    self.savePeopleError = savePeopleError
    self.deleteAllPeopleError = deleteAllPeopleError
  }
  
  // MARK: - Functions
  
  func getPeople(for query: String?) throws -> [Officee.LocalPerson] {
    receivedMessages.append(.getPeople(query: query))
    try throwErrorIfExists(getPeopleError)
    return people
  }
  
  func hasStoredPeople() throws -> Bool {
    receivedMessages.append(.checkStoredPeople)
    try throwErrorIfExists(hasStoredPeopleError)
    return !people.isEmpty
  }
  
  func save(people: [Officee.LocalPerson]) throws {
    receivedMessages.append(.savePeople(people))
    try throwErrorIfExists(savePeopleError)
  }
  
  func deleteAllPeople() throws {
    receivedMessages.append(.deleteAllPeople)
    try throwErrorIfExists(deleteAllPeopleError)
  }
  
  // MARK: - Private Functions
  
  private func throwErrorIfExists(_ error: Error?) throws {
    guard let error = error else { return }
    
    throw error
  }
}

struct DummyPeopleFeedStorage: PeopleFeedStorage {
  func getPeople(for query: String?) throws -> [Officee.LocalPerson] {
    []
  }
  
  func hasStoredPeople() throws -> Bool {
    false
  }
  
  func save(people: [Officee.LocalPerson]) throws {}
  
  func deleteAllPeople() throws {}
}
