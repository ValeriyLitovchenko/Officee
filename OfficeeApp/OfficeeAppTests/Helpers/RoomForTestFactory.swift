//
//  RoomForTestFactory.swift
//  OfficeeAppTests
//
//  Created by Valeriy L on 30.10.2022.
//

import Officee

enum RoomForTestFactory {
  static func makeRoom(id: String) -> Room {
    Room(
      id: id,
      name: "mane_ \(id)",
      isOccupied: false,
      maxOccupancy: .zero)
  }
}
