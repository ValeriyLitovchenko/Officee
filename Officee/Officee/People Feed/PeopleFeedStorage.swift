//
//  PeopleFeedStorage.swift
//  Officee
//
//  Created by Valeriy L on 08.10.2022.
//

import Foundation

/// Interface for people storage
public protocol PeopleFeedStorage {
  /// Performs people fetching with query
  func getPeople(for query: String?) throws -> [LocalPerson]
  /// Check that there's stored people
  func hasStoredPeople() throws -> Bool
  /// Save people
  func save(people: [LocalPerson]) throws
  /// Remove all people
  func deleteAll() throws
}
