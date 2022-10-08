//
//  RoomsFeedRepository.swift
//  OfficeeApp
//
//  Created by Valeriy L on 08.10.2022.
//

import Combine

protocol RoomsFeedRepository {
  func getRooms(with request: RoomsFeedRequest) -> AnyPublisher<[Room], Swift.Error>
}
