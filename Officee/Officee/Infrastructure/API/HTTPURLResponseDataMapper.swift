//
//  HTTPURLResponseDataMapper.swift
//  Officee
//
//  Created by Valeriy L on 12.10.2022.
//

import Foundation

public struct HTTPURLResponseDataMapper {
  public enum Error: Swift.Error {
    case invalidData
  }
  
  public static func map(_ data: Data, from response: HTTPURLResponse) throws -> Data {
    guard response.isSuccessful, !data.isEmpty else {
      throw Error.invalidData
    }
    
    return data
  }
}
