//
//  RoomsFeedResultMapperTests.swift
//  OfficeeTests
//
//  Created by Valeriy L on 24.10.2022.
//

import XCTest
import Officee

final class RoomsFeedResultMapperTests: XCTestCase {
  func test_map_deliversInvalidDataErrorOnEmptyData() {
    let emptyData = Data()
    
    XCTAssertThrowsError(
      try RoomsFeedResultMapper.map(emptyData)
    )
  }
  
  func test_map_deliversInvalidDataErrorOnInvalidJSON() {
    let invalidJSON = Data("invalid json".utf8)
    
    XCTAssertThrowsError(
      try RoomsFeedResultMapper.map(invalidJSON)
    )
  }
  
  func test_map_deliversNoRoomsWithEmptyJSONList() throws {
    let expectedEmptyArray = [Room]()
    let emptyJson = try JSONSerialization.data(withJSONObject: expectedEmptyArray)
    
    let result = try RoomsFeedResultMapper.map(emptyJson)
    
    XCTAssertEqual(result, expectedEmptyArray)
  }
  
  func test_map_deliversRoomsWithJSONList() throws {
    let identifier = "1"
    let room = room(
      id: identifier,
      name: identifier,
      isOccupied: false,
      maxOccupancy: 1)
    
    let json = try JSONSerialization.data(withJSONObject: [room.json])
    
    let result = try RoomsFeedResultMapper.map(json)
    
    XCTAssertEqual(result, [room.room])
  }
  
  // MARK: - Helpers
  
  private func room(
    id: Room.Identifier,
    name: String,
    isOccupied: Bool,
    maxOccupancy: Int
  ) -> (room: Room, json: [String: Any]) {
    let room = Room(
      id: id,
      name: name,
      isOccupied: isOccupied,
      maxOccupancy: maxOccupancy)
    
    let json = [
      "id": id,
      "name": name,
      "isOccupied": isOccupied,
      "maxOccupancy": maxOccupancy
    ].compactMapValues { $0 }
    
    return (room, json)
  }
}
