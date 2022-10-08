//
//  ManagedPerson+Operations.swift
//  Officee
//
//  Created by Valeriy L on 08.10.2022.
//

import CoreData

extension ManagedPerson {
  static func isPeopleStored(in context: NSManagedObjectContext) throws -> Bool {
    // swiftlint:disable force_unwrapping
    let request = NSFetchRequest<ManagedPerson>(entityName: entity().name!)
    request.returnsObjectsAsFaults = false
    request.fetchLimit = 1
    return (try context.count(for: request)) > .zero
  }
  
  static func findPeople(
    in context: NSManagedObjectContext,
    query: String? = nil
  ) throws -> [ManagedPerson] {
    // swiftlint:disable force_unwrapping
    let request = NSFetchRequest<ManagedPerson>(entityName: entity().name!)
    request.returnsObjectsAsFaults = false
    request.sortDescriptors = [NSSortDescriptor(key: "fullName", ascending: true)]
    if let query = query {
      request.predicate = NSPredicate(format: "fullName CONTAINS[cd] %@", query)
    }
    return try context.fetch(request)
  }
  
  static func deleteAll(in context: NSManagedObjectContext, where ids: [String]? = nil) throws {
    let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity().name!)
    if let ids = ids {
      deleteFetch.returnsDistinctResults = true
      deleteFetch.propertiesToFetch = ["id"]
      deleteFetch.predicate = NSPredicate(format: "id in %@", ids)
    }
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
    try context.execute(deleteRequest)
  }
}
