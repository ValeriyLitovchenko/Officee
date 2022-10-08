//
//  ManagedPerson+CoreDataClass.swift
//  
//
//  Created by Valeriy L on 08.10.2022.
//
//

import CoreData

@objc(ManagedPerson)
public class ManagedPerson: NSManagedObject {}

extension ManagedPerson {
  @discardableResult
  static func person(
    from localPerson: LocalPerson,
    in context: NSManagedObjectContext
  ) -> ManagedPerson {
    let managedModel = ManagedPerson(context: context)
    managedModel.id = localPerson.id
    managedModel.firstName = localPerson.firstName
    managedModel.lastName = localPerson.lastName
    managedModel.fullName = localPerson.fullName
    managedModel.avatar = localPerson.avatar
    managedModel.email = localPerson.email
    managedModel.jobTitle = localPerson.jobTitle
    managedModel.favoriteColor = localPerson.favoriteColor
    managedModel.meetingDescription = localPerson.meetingDescription
    return managedModel
  }
  
  var asLocalPerson: LocalPerson {
    LocalPerson(
      id: id!,
      firstName: firstName!,
      lastName: lastName!,
      avatar: avatar!,
      email: email!,
      jobTitle: jobTitle!,
      favoriteColor: favoriteColor!,
      meetingDescription: meetingDescription)
  }
}
