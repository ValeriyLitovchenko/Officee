//
//  PeopleFeedResultMapper.swift
//  Officee
//
//  Created by Valeriy L on 08.10.2022.
//

import Foundation

/// Provide functionality for response + data validation while People Feed  decoding from  response
public enum PeopleFeedResultMapper {
  public static func map(_ data: Data) throws -> [Person] {
    let people = try JSONDecoder().decode([RemotePersonModel].self, from: data)
    return people.map(\.asDomainModel)
  }
}

private struct RemotePersonModel: Decodable, Identifiable {
  struct Meeting: Decodable {
    let title: String
    let body: String
    var description: String {
      "\(body) \(title)"
    }
  }
  
  typealias Identifier = String
  let id: Identifier
  let firstName: String
  let lastName: String
  let avatar: String
  let email: String
  let jobtitle: String
  let favouriteColor: String
  var meeting: Meeting? { data }
  private let data: Meeting?
}

private extension RemotePersonModel {
  var asDomainModel: Person {
    Person(
      id: id,
      firstName: firstName,
      lastName: lastName,
      avatar: avatar,
      email: email,
      jobTitle: jobtitle,
      favoriteColor: favouriteColor,
      meetingDescription: meeting?.description)
  }
}
