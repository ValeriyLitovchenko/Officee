//
//  TabBarSceneFactory.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import Foundation

struct TabBarSceneFactoryImpl: TabBarSceneFactory {
  let serviceLocating: ServiceLocating
}

protocol TabBarSceneFactory: PeopleFeedCoordinatorFactory {}
