//
//  PersonForTestFactory.swift
//  OfficeeAppTests
//
//  Created by Valeriy L on 30.10.2022.
//

import Officee

enum PersonForTestFactory {
  static func makePerson(id: String) -> (person: Person, json: [String: Any]) {
    let person = Person(
      id: id,
      firstName: "firstName_\(id)",
      lastName: "lastName_\(id)",
      avatar: "avatar_\(id)",
      email: "email_\(id)",
      jobTitle: "jobTitle_\(id)",
      favoriteColor: "favoriteColor_\(id)",
      meetingDescription: nil)
    
    let json = [
      "id": id,
      "firstName": person.firstName,
      "lastName": person.lastName,
      "avatar": person.avatar,
      "email": person.email,
      "jobtitle": person.jobTitle,
      "favouriteColor": person.favoriteColor
    ].compactMapValues { $0 }
    
    return (person, json)
  }
  
  static func makeLocalPerson(id: String) -> (person: LocalPerson, json: [String: Any]) {
    let person = LocalPerson(
      id: id,
      firstName: "firstName_\(id)",
      lastName: "lastName_\(id)",
      avatar: "avatar_\(id)",
      email: "email_\(id)",
      jobTitle: "jobTitle_\(id)",
      favoriteColor: "favoriteColor_\(id)",
      meetingDescription: nil)
    
    let json = [
      "id": id,
      "firstName": person.firstName,
      "lastName": person.lastName,
      "avatar": person.avatar,
      "email": person.email,
      "jobtitle": person.jobTitle,
      "favouriteColor": person.favoriteColor
    ].compactMapValues { $0 }
    
    return (person, json)
  }
}
