//
//  RoomsFeedResultMapper.swift
//  Officee
//
//  Created by Valeriy L on 08.10.2022.
//

import Foundation

/// Provide functionality for response + data validation while Rooms Feed  decoding from  response
public enum RoomsFeedResultMapper {
  public static func map(data: Data, from response: HTTPURLResponse) throws -> [Room] {
    try HTTPURLResponseValidator.validate(response)
    let rooms = try JSONDecoder().decode([RemoteRoomModel].self, from: data)
    return rooms.map(\.asDomainModel)
  }
}

private struct RemoteRoomModel: Decodable, Identifiable {
  typealias Identifier = String
  let id: Identifier
  // Use id as name because API doesn't provide one
  // In real world better to use separate id and name properties
  var name: String { id }
  let isOccupied: Bool
  let maxOccupancy: Int
}

private extension RemoteRoomModel {
  var asDomainModel: Room {
    Room(
      id: id,
      name: name,
      isOccupied: isOccupied,
      maxOccupancy: maxOccupancy)
  }
}
