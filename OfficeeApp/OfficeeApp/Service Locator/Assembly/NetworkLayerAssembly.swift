//
//  NetworkLayerAssembly.swift
//  OfficeeApp
//
//  Created by Valeriy L on 08.10.2022.
//

import Foundation
import Officee
import Swinject

// swiftlint:disable force_unwrapping

struct NetworkLayerAssembly: Swinject.Assembly {
  func assemble(container: Container) {
    container.register(HTTPClient.self) { _ in
      URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    }
    
    container.register(NetworkService.self) { resolver in
      RestApiNetworkService(
        baseURL: URL(string: AppConstants.apiBaseURLString)!,
        httpClient: resolver.resolve())
    }
  }
}
