//
//  Person.swift
//  Officee
//
//  Created by Valeriy L on 08.10.2022.
//

import Foundation

public struct Person: Identifiable, Equatable {
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
  
  public init(
    id: Person.Identifier,
    firstName: String,
    lastName: String,
    avatar: String,
    email: String,
    jobTitle: String,
    favoriteColor: String,
    meetingDescription: String?
  ) {
    self.id = id
    self.firstName = firstName
    self.lastName = lastName
    self.avatar = avatar
    self.email = email
    self.jobTitle = jobTitle
    self.favoriteColor = favoriteColor
    self.meetingDescription = meetingDescription
  }
}
