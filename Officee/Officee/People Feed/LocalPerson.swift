//
//  LocalPerson.swift
//  Officee
//
//  Created by Valeriy L on 08.10.2022.
//

import Foundation

public struct LocalPerson: Identifiable {
  public typealias Identifier = String
  public let id: Identifier
  public let firstName: String
  public let lastName: String
  public let avatar: String
  public let email: String
  public let jobTitle: String
  public let favoriteColor: String
  public let meetingDescription: String?
  
  public var fullName: String {
    "\(firstName) \(lastName)"
  }
}
