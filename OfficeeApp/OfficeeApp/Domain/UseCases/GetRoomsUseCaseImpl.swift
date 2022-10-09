//
//  GetRoomsUseCaseImpl.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import Officee
import Combine

struct GetRoomsUseCaseImpl: GetRoomsUseCase {
  let repository: RoomsFeedRepository
  
  func invoke(with request: RoomsFeedRequest) -> AnyPublisher<[Room], Error> {
    repository.getRooms(with: request)
  }
}
