//
//  RoomsFeedStorage.swift
//  OfficeeAppTests
//
//  Created by Valeriy L on 31.10.2022.
//

import Foundation
import Officee

final class RoomsFeedStorageSpy: RoomsFeedStorage {
  enum ReceivedMessage: Equatable {
    case getRooms(query: String?)
    case checkStoredRooms
    case saveRooms([Officee.LocalRoom])
    case deleteAllRooms
  }
  
  // MARK: - Properties
  
  let rooms: [Officee.LocalRoom]
  let getRoomsError: Error?
  let hasStoredRoomsError: Error?
  let saveRoomsError: Error?
  let deleteAllRoomsError: Error?
  private(set) var receivedMessages = [ReceivedMessage]()
  
  // MARK: - Constructor
  
  init(
    rooms: [Officee.LocalRoom],
    getRoomsError: Error? = nil,
    hasStoredRoomsError: Error? = nil,
    saveRoomsError: Error? = nil,
    deleteAllRoomsError: Error? = nil
  ) {
    self.rooms = rooms
    self.getRoomsError = getRoomsError
    self.hasStoredRoomsError = hasStoredRoomsError
    self.saveRoomsError = saveRoomsError
    self.deleteAllRoomsError = deleteAllRoomsError
  }
  
  // MARK: - Funcitons
  
  func getRooms(for query: String?) throws -> [LocalRoom] {
    receivedMessages.append(.getRooms(query: query))
    try throwErrorIfExists(getRoomsError)
    return rooms
  }
  
  func hasStoredRooms() throws -> Bool {
    receivedMessages.append(.checkStoredRooms)
    try throwErrorIfExists(hasStoredRoomsError)
    return !rooms.isEmpty
  }
  
  func save(rooms: [LocalRoom]) throws {
    receivedMessages.append(.saveRooms(rooms))
    try throwErrorIfExists(saveRoomsError)
  }
  
  func deleteAllRooms() throws {
    receivedMessages.append(.deleteAllRooms)
    try throwErrorIfExists(deleteAllRoomsError)
  }
  
  // MARK: - Private Functions
  
  private func throwErrorIfExists(_ error: Error?) throws {
    guard let error = error else { return }
    
    throw error
  }
}

struct DummyRoomsFeedStorage: RoomsFeedStorage {
  func getRooms(for query: String?) throws -> [Officee.LocalRoom] {
    []
  }
  
  func hasStoredRooms() throws -> Bool {
    false
  }
  
  func save(rooms: [Officee.LocalRoom]) throws {}
  
  func deleteAllRooms() throws {}
}
