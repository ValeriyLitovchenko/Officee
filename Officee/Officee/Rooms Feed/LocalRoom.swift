//
//  LocalRoom.swift
//  Officee
//
//  Created by Valeriy L on 08.10.2022.
//

import Foundation

public struct LocalRoom: Identifiable, Equatable {
  public typealias Identifier = String
  public let id: Identifier
  public let name: String
  public let isOccupied: Bool
  public let maxOccupancy: Int
  
  public init(
    id: LocalRoom.Identifier,
    name: String,
    isOccupied: Bool,
    maxOccupancy: Int
  ) {
    self.id = id
    self.name = name
    self.isOccupied = isOccupied
    self.maxOccupancy = maxOccupancy
  }
}
