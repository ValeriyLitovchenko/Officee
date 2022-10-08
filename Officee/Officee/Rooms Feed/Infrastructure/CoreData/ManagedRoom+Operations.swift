//
//  ManagedRoom+Operations.swift
//  Officee
//
//  Created by Valeriy L on 08.10.2022.
//

import CoreData

extension ManagedRoom {
  static func isRoomsStored(in context: NSManagedObjectContext) throws -> Bool {
    // swiftlint:disable force_unwrapping
    let request = NSFetchRequest<ManagedRoom>(entityName: entity().name!)
    request.returnsObjectsAsFaults = false
    request.fetchLimit = 1
    return (try context.count(for: request)) > .zero
  }
  
  static func findRooms(
    in context: NSManagedObjectContext,
    query: String? = nil
  ) throws -> [ManagedRoom] {
    // swiftlint:disable force_unwrapping
    let request = NSFetchRequest<ManagedRoom>(entityName: entity().name!)
    request.returnsObjectsAsFaults = false
    request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
    if let query = query {
      request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", query)
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
