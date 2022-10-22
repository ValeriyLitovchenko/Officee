//
//  CoreDataStorage.swift
//  Officee
//
//  Created by Valeriy L on 08.10.2022.
//

import CoreData

public final class CoreDataStorage {
  
  // MARK: - Properties
  
  private static let modelName = "OfficeeStore"
  private static let model: NSManagedObjectModel? = {
    Bundle(for: CoreDataStorage.self)
      .url(forResource: modelName, withExtension: "momd")
      .flatMap(NSManagedObjectModel.init(contentsOf:))
  }()
  
  private let persistentContainer: NSPersistentContainer
  /// Background context
  private let context: NSManagedObjectContext
  
  enum StoreError: Error {
    case modelNotFound
  }
  
  // MARK: - Constructor
  
  public init(storeURL: URL) throws {
    guard let model = CoreDataStorage.model else {
      throw StoreError.modelNotFound
    }
    
    let container = NSPersistentContainer(
      name: CoreDataStorage.modelName,
      managedObjectModel: model)
    container.persistentStoreDescriptions = [
      NSPersistentStoreDescription(url: storeURL)
    ]
    
    var error: Swift.Error?
    container.loadPersistentStores { error = $1 }
    try error.map { throw $0 }
    
    persistentContainer = container
    context = container.newBackgroundContext()
  }
  
  deinit {
    cleanUpReferencesToPersistentStores()
  }
  
  // MARK: - Functions
  
  public func performSync<Result>(
    _ action: (NSManagedObjectContext) -> Swift.Result<Result, Error>
  ) throws -> Result {
    var result: Swift.Result<Result, Error>!
    context.performAndWait { [context] in
      result = action(context)
    }
    return try result.get()
  }
  
  private func cleanUpReferencesToPersistentStores() {
    context.performAndWait { [persistentContainer] in
      let coordinator = persistentContainer.persistentStoreCoordinator
      try? coordinator.persistentStores.forEach(coordinator.remove)
    }
  }
}
