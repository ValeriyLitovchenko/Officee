//
//  CoreDataRoomsFeedStorage.swift
//  Officee
//
//  Created by Valeriy L on 08.10.2022.
//

import Foundation

extension CoreDataStorage: RoomsFeedStorage {
  public func getRooms(for query: String?) throws -> [LocalRoom] {
    try performSync { context in
      Result {
        let result = try ManagedRoom.findRooms(in: context, query: query)
        return result.map(\.asLocalRoom)
      }
    }
  }
  
  public func hasStoredRooms() throws -> Bool {
    try performSync { context in
      Result {
        try ManagedRoom.isRoomsStored(in: context)
      }
    }
  }
  
  public func save(rooms: [LocalRoom]) throws {
    try performSync { context in
      Result {
        try ManagedRoom.deleteAll(in: context, where: rooms.map(\.id))
        rooms.forEach { room in
          ManagedRoom.room(from: room, in: context)
        }
        try context.save()
      }
    }
  }
  
  public func deleteAllRooms() throws {
    try performSync { context in
      Result {
        try ManagedRoom.deleteAll(in: context)
        try context.save()
      }
    }
  }
}
