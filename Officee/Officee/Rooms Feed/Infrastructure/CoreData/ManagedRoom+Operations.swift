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
    let nameKey = (\ManagedRoom.name).string
    request.sortDescriptors = [NSSortDescriptor(key: nameKey, ascending: true)]
    if let query = query {
      request.predicate = NSPredicate(format: "\(nameKey) CONTAINS[cd] %@", query)
    }
    return try context.fetch(request)
  }
  
  static func deleteAll(in context: NSManagedObjectContext, where ids: [String]? = nil) throws {
    let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity().name!)
    if let ids = ids {
      let idKey = (\ManagedRoom.id).string
      deleteFetch.propertiesToFetch = [idKey]
      deleteFetch.predicate = NSPredicate(format: "\(idKey) in %@", ids)
      deleteFetch.returnsDistinctResults = true
    }
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
    try context.execute(deleteRequest)
  }
}
