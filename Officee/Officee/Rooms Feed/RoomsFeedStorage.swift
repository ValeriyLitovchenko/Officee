//
//  RoomsFeedStorage.swift
//  Officee
//
//  Created by Valeriy L on 08.10.2022.
//

import Foundation

/// Interface for rooms storage
public protocol RoomsFeedStorage {
  /// Performs rooms fetching with query
  func getRooms(for query: String?) throws -> [LocalRoom]
  /// Check that there's stored rooms
  func hasStoredRooms() throws -> Bool
  /// Save rooms
  func save(rooms: [LocalRoom]) throws
  /// Remove all rooms
  func deleteAllRooms() throws
}
