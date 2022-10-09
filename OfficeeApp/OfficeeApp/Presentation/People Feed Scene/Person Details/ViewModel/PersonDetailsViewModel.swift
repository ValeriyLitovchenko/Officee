//
//  PersonDetailsViewModel.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import OfficeeiOSCore

protocol PersonDetailsViewModel {
  var statePublisher: ValuePublisher<PersonDetailsViewModelState> { get }
  
  func loadData()
  func sendMessageAction()
}

typealias PersonDetailsViewModelState = CommonTableViewModelState
