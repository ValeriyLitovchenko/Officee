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
  
  private let networkService: NetworkService
  private let roomsStorage: RoomsFeedStorage
  
  // MARK: - Constructor
  
  init(
    networkService: NetworkService,
    roomsStorage: RoomsFeedStorage
  ) {
    self.networkService = networkService
    self.roomsStorage = roomsStorage
  }
  
  // MARK: - Functions
  
  func getRooms(with request: RoomsFeedRequest) -> AnyPublisher<[Room], Error> {
    Just(request)
      .flatMap { [weak self] request -> AnyPublisher<[Room], Error> in
        guard let self = self else {
          return Empty<[Room], Error>().eraseToAnyPublisher()
        }
        
        let hasStoredRooms = (try? self.roomsStorage.hasStoredRooms()) ?? false
        guard request.shouldRefresh
                || (hasStoredRooms == false) else {
          return Just([Room]())
            .setFailureType(to: Swift.Error.self)
            .eraseToAnyPublisher()
        }
        
        return self.getRoomsFromNetworkAndStore()
      }
      .flatMap { [weak self] _ -> AnyPublisher<[Room], Error> in
        guard let self = self else {
          return Empty<[Room], Error>().eraseToAnyPublisher()
        }
        
        return self.getRoomsFromStorage(with: request.query)
      }
      .eraseToAnyPublisher()
  }
  
  // MARK: - Private Functions
  
  private func getRoomsFromNetworkAndStore() -> AnyPublisher<[Room], Error> {
    getRoomsFromNetwork()
      .handleEvents(receiveOutput: { [roomsStorage] rooms in
        try? roomsStorage.deleteAllRooms()
        try? roomsStorage.save(rooms: rooms.toLocalRooms())
      })
      .eraseToAnyPublisher()
  }
  
  private func getRoomsFromNetwork() -> AnyPublisher<[Room], Error> {
    let apiEndpoint = RoomsFeedApiEndpoint.getRooms
    return networkService.getPublisher(from: apiEndpoint.urlRequest(baseURL:))
      .tryMap(HTTPURLResponseDataMapper.map)
      .tryMap(RoomsFeedResultMapper.map)
      .retry(2)
      .eraseToAnyPublisher()
  }
  
  private func getRoomsFromStorage(with query: String?) -> AnyPublisher<[Room], Error> {
    Deferred { [roomsStorage] in
      Future { promise in
        promise(Result {
          try roomsStorage.getRooms(for: query)
        })
      }
    }
    .map { $0.toDomain() }
    .eraseToAnyPublisher()
  }
}

private extension Array where Element == Room {
  func toLocalRooms() -> [LocalRoom] {
    map { room in
      LocalRoom(
        id: room.id,
        name: room.name,
        isOccupied: room.isOccupied,
        maxOccupancy: room.maxOccupancy)
    }
  }
}

private extension Array where Element == LocalRoom {
  func toDomain() -> [Room] {
    map { room in
      Room(
        id: room.id,
        name: room.name,
        isOccupied: room.isOccupied,
        maxOccupancy: room.maxOccupancy)
    }
  }
}
