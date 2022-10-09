//
//  GetRoomsUseCase.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import Officee
import Combine

protocol GetRoomsUseCase {
  func invoke(with request: RoomsFeedRequest) -> AnyPublisher<[Room], Error>
}
