//
//  StorageAssembly.swift
//  OfficeeApp
//
//  Created by Valeriy L on 08.10.2022.
//

import Foundation
import Officee
import CoreData.NSPersistentContainer
import Swinject

struct StorageAssembly: Swinject.Assembly {
  func assemble(container: Container) {
    container.register(CoreDataStorage.self) { _ in
      let url = NSPersistentContainer
            .defaultDirectoryURL()
            .appendingPathComponent("officee-storage.sqlite")
      do {
        return try CoreDataStorage(storeURL: url)
      } catch {
        fatalError("CoreDataStorage instantiation failed with error: \(error.localizedDescription)")
      }
    }
    .inObjectScope(.container)
    
    container.register(PeopleFeedStorage.self) { resolver in
      resolver.resolve(type: CoreDataStorage.self)
    }
    
    container.register(RoomsFeedStorage.self) { resolver in
      resolver.resolve(type: CoreDataStorage.self)
    }
  }
}
