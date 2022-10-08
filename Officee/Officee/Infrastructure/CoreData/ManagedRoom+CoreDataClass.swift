//
//  ManagedRoom+CoreDataClass.swift
//  
//
//  Created by Valeriy L on 08.10.2022.
//
//

import CoreData

@objc(ManagedRoom)
public class ManagedRoom: NSManagedObject {}

extension ManagedRoom {
  @discardableResult
  static func room(
    from localRoom: LocalRoom,
    in context: NSManagedObjectContext
  ) -> ManagedRoom {
    let managedModel = ManagedRoom(context: context)
    managedModel.id = localRoom.id
    managedModel.name = localRoom.name
    managedModel.maxOccupancy = Int64(localRoom.maxOccupancy)
    managedModel.isOccupied = localRoom.isOccupied
    return managedModel
  }
  
  var asLocalRoom: LocalRoom {
    LocalRoom(
      id: id!,
      name: name!,
      isOccupied: isOccupied,
      maxOccupancy: Int(maxOccupancy))
  }
}
