//
//  PeopleFeedResultMapperTests.swift
//  OfficeeTests
//
//  Created by Valeriy L on 24.10.2022.
//

import XCTest
import Officee

final class PeopleFeedResultMapperTests: XCTestCase {
  func test_map_deliversInvalidDataErrorOnEmptyData() {
    let emptyData = Data()
    
    XCTAssertThrowsError(
      try PeopleFeedResultMapper.map(emptyData)
    )
  }
  
  func test_map_deliversInvalidDataErrorOnInvalidJSON() {
    let invalidJSON = Data("invalid json".utf8)
    
    XCTAssertThrowsError(
      try PeopleFeedResultMapper.map(invalidJSON)
    )
  }
  
  func test_map_deliversNoPeopleWithEmptyJSONList() throws {
    let expectedEmptyArray = [Person]()
    let emptyJson = try JSONSerialization.data(withJSONObject: expectedEmptyArray)
    
    let result = try PeopleFeedResultMapper.map(emptyJson)
    
    XCTAssertEqual(result, expectedEmptyArray)
  }
  
  func test_map_deliversPeopleWithPeopleJSON() throws {
    let identifier = "1"
    let person = makePerson(
      id: "\(identifier)",
      firstName: "firstName_\(identifier)",
      lastName: "lastName_\(identifier)",
      avatar: "avatar_\(identifier)",
      email: "email_\(identifier)",
      jobTitle: "jobTitle_\(identifier)",
      favoriteColor: "favoriteColor_\(identifier)",
      meetingDescription: .init(
        title: "description",
        body: "meeting")
    )
    
    let json = try JSONSerialization.data(withJSONObject: [person.json])
    
    let result = try PeopleFeedResultMapper.map(json)
    
    XCTAssertEqual(result, [person.person])
  }
  
  // MARK: - Helpers
  
  private func makePerson(
    id: String,
    firstName: String,
    lastName: String,
    avatar: String,
    email: String,
    jobTitle: String,
    favoriteColor: String,
    meetingDescription: MeetingDescroptionForTest?
  ) -> (person: Person, json: [String: Any]) {
    
    let person = Person(
      id: id,
      firstName: firstName,
      lastName: lastName,
      avatar: avatar,
      email: email,
      jobTitle: jobTitle,
      favoriteColor: favoriteColor,
      meetingDescription: meetingDescription?.description)
    
    let json = [
      "id": id,
      "firstName" : firstName,
      "lastName": lastName,
      "avatar": avatar,
      "email": email,
      "jobtitle": jobTitle,
      "favouriteColor": favoriteColor,
      "data": meetingDescription?.json ?? [:]
    ].compactMapValues { $0 }
    
    return (person, json)
  }
}


struct MeetingDescroptionForTest {
  let title: String
  let body: String
  
  var description: String {
    "\(body) \(title)"
  }
  
  var json: [String: Any] {
    [
      "title": title,
      "body": body
    ]
  }
}
