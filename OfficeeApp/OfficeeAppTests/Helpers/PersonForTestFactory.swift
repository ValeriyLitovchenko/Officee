//
//  PersonForTestFactory.swift
//  OfficeeAppTests
//
//  Created by Valeriy L on 30.10.2022.
//

import Officee

enum PersonForTestFactory {
  static func makePerson(id: String) -> Person {
    Person(
      id: id,
      firstName: "firstName_\(id)",
      lastName: "lastName_\(id)",
      avatar: "avatar_\(id)",
      email: "email_\(id)",
      jobTitle: "jobTitle_\(id)",
      favoriteColor: "favoriteColor_\(id)",
      meetingDescription: "meetingDescription_\(id)")
  }
}
