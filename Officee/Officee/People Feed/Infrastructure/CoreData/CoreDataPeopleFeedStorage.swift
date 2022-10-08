//
//  CoreDataPeopleFeedStorage.swift
//  Officee
//
//  Created by Valeriy L on 08.10.2022.
//

import Foundation

extension CoreDataStorage: PeopleFeedStorage {
  public func getPeople(for query: String?) throws -> [LocalPerson] {
    try performSync { context in
      Result {
        let result = try ManagedPerson.findPeople(in: context, query: query)
        return result.map(\.asLocalPerson)
      }
    }
  }
  
  public func hasStoredPeople() throws -> Bool {
    try performSync { context in
      Result {
        try ManagedPerson.isPeopleStored(in: context)
      }
    }
  }
  
  public func save(people: [LocalPerson]) throws {
    try performSync { context in
      Result {
        try ManagedPerson.deleteAll(in: context, where: people.map(\.id))
        people.forEach { person in
          ManagedPerson.person(from: person, in: context)
        }
        try context.save()
      }
    }
  }
  
  public func deleteAllPeople() throws {
    try performSync { context in
      Result {
        try ManagedPerson.deleteAll(in: context)
        try context.save()
      }
    }
  }
}
