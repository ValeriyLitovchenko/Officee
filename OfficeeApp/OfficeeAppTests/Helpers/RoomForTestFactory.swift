//
//  RoomForTestFactory.swift
//  OfficeeAppTests
//
//  Created by Valeriy L on 30.10.2022.
//

import Officee

enum RoomForTestFactory {
  static func makeRoom(id: String) -> (room: Room, json: [String: Any]) {
    let room = Room(
      id: id,
      name: "mane_ \(id)",
      isOccupied: false,
      maxOccupancy: .zero)
    
    let json = [
      "id": room.id,
      "name": room.name,
      "isOccupied": room.isOccupied,
      "maxOccupancy": room.maxOccupancy
    ].compactMapValues { $0 }
    
    return (room, json)
  }
  
  static func makeLocalRoom(id: String) -> (room: LocalRoom, json: [String: Any]) {
    let room = LocalRoom(
      id: id,
      name: "mane_ \(id)",
      isOccupied: false,
      maxOccupancy: .zero)
    
    let json = [
      "id": room.id,
      "name": room.name,
      "isOccupied": room.isOccupied,
      "maxOccupancy": room.maxOccupancy
    ].compactMapValues { $0 }
    
    return (room, json)
  }
}
