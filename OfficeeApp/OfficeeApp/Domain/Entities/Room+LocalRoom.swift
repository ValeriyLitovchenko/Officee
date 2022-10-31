//
//  Room+LocalRoom.swift
//  OfficeeApp
//
//  Created by Valeriy L on 31.10.2022.
//

import Officee

extension Room {
  var toLocalRoom: LocalRoom {
    LocalRoom(
      id: id,
      name: name,
      isOccupied: isOccupied,
      maxOccupancy: maxOccupancy)
  }
}

extension LocalRoom {
  var toDomain: Room {
    Room(
      id: id,
      name: name,
      isOccupied: isOccupied,
      maxOccupancy: maxOccupancy)
  }
}
