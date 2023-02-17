//
//  ProfileViewModel.swift
//  MessengerClone
//
//  Created by ENMANUEL TORRES on 17/02/23.
//

import Foundation

enum ProfileViewModelType {
    case info, logout
}

struct ProfileViewModel {
    let viewModelType: ProfileViewModelType
    let title: String
    let handler: (() -> Void)?
}
