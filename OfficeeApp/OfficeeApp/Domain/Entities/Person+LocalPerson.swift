//
//  Person+LocalPerson.swift
//  OfficeeApp
//
//  Created by Valeriy L on 31.10.2022.
//

import Officee

extension Person {
  var toLocalPerson: LocalPerson {
    LocalPerson(
      id: id,
      firstName: firstName,
      lastName: lastName,
      avatar: avatar,
      email: email,
      jobTitle: jobTitle,
      favoriteColor: favoriteColor,
      meetingDescription: meetingDescription)
  }
}

extension LocalPerson {
  var toDomain: Person {
    Person(
      id: id,
      firstName: firstName,
      lastName: lastName,
      avatar: avatar,
      email: email,
      jobTitle: jobTitle,
      favoriteColor: favoriteColor,
      meetingDescription: meetingDescription)
  }
}
