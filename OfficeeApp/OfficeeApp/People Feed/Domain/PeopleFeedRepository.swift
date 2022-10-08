//
//  PeopleFeedRepository.swift
//  OfficeeApp
//
//  Created by Valeriy L on 08.10.2022.
//

import Combine

protocol PeopleFeedRepository {
  func getPeople(with request: PeopleFeedRequest) -> AnyPublisher<[Person], Swift.Error>
}
