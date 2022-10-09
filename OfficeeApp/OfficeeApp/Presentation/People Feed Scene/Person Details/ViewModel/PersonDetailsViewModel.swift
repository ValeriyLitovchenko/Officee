//
//  PersonDetailsViewModel.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import OfficeeiOSCore

protocol PersonDetailsViewModel {
  var sceneTitle: String { get }
  var statePublisher: ValuePublisher<PersonDetailsViewModelState> { get }
  
  func loadData()
}

typealias PersonDetailsViewModelState = CommonTableViewModelState
