//
//  LoadFeedsUseCaseImpl.swift
//  OfficeeApp
//
//  Created by Valeriy L on 08.10.2022.
//

import Combine

struct LoadFeedsUseCaseImpl: LoadFeedsUseCase {
  let peopleRepository: PeopleFeedRepository
  let roomsRepository: RoomsFeedRepository
  
  func invoke() -> AnyPublisher<Void, Error> {
    Publishers.Zip(
      peopleRepository.getPeople(with: .refreshRequest),
      roomsRepository.getRooms(with: .refreshRequest)
    )
    .map { _ in () }
    .eraseToAnyPublisher()
  }
}
