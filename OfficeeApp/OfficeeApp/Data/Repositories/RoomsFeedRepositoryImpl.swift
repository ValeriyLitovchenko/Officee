//
//  RoomsFeedRepositoryImpl.swift
//  OfficeeApp
//
//  Created by Valeriy L on 08.10.2022.
//

import Officee
import Combine

final class RoomsFeedRepositoryImpl: RoomsFeedRepository {
  
  // MARK: - Properties
  
  private let httpClient: HTTPClient
  private let urlRequestFactory: URLRequestFactory
  private let roomsStorage: RoomsFeedStorage
  
  // MARK: - Constructor
  
  init(
    httpClient: HTTPClient,
    urlRequestFactory: URLRequestFactory,
    roomsStorage: RoomsFeedStorage
  ) {
    self.httpClient = httpClient
    self.urlRequestFactory = urlRequestFactory
    self.roomsStorage = roomsStorage
  }
  
  // MARK: - Functions
  
  func getRooms(with request: RoomsFeedRequest) -> AnyPublisher<[Room], Error> {
    Just(request)
      .tryMap { [roomsStorage] request in
        !(try roomsStorage.hasStoredRooms()) || request.shouldRefresh
      }
      .flatMap { [weak self] shouldRefresh -> AnyPublisher<[Room], Error> in
        guard shouldRefresh, let self = self else {
          return JustAnyPublisher(.init())
        }
        
        return self.getRoomsFromNetworkAndStore()
      }
      .tryMap { [roomsStorage, request] _ in
        try roomsStorage.getRooms(for: request.query)
      }
      .map { $0.toDomain() }
      .eraseToAnyPublisher()
  }
  
  // MARK: - Private Functions
  
  private func getRoomsFromNetworkAndStore() -> AnyPublisher<[Room], Error> {
    getRoomsFromNetwork()
      .handleResult { [roomsStorage] rooms in
        try roomsStorage.deleteAllRooms()
        try roomsStorage.save(rooms: rooms.toLocalRooms())
      }
  }
  
  private func getRoomsFromNetwork() -> AnyPublisher<[Room], Error> {
    let apiEndpoint = RoomsFeedApiEndpoint.getRooms
    let request = urlRequestFactory.requestFor(api: apiEndpoint)
    
    return httpClient.getPublisher(from: request)
      .tryMap(HTTPURLResponseDataMapper.map)
      .tryMap(RoomsFeedResultMapper.map)
      .eraseToAnyPublisher()
  }
}

private extension Array where Element == Room {
  func toLocalRooms() -> [LocalRoom] {
    map(\.toLocalRoom)
  }
}

private extension Array where Element == LocalRoom {
  func toDomain() -> [Room] {
    map(\.toDomain)
  }
}
