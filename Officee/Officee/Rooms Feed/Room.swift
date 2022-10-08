//
//  Room.swift
//  Officee
//
//  Created by Valeriy L on 08.10.2022.
//

import Foundation

public struct Room: Identifiable {
  public typealias Identifier = String
  public let id: Identifier
  public let name: String
  public let isOccupied: Bool
  public let maxOccupancy: Int
}
