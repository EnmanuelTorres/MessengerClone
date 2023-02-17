//
//  ConversationsModels.swift
//  MessengerClone
//
//  Created by ENMANUEL TORRES on 17/02/23.
//

import Foundation

struct conversation {
    let id : String
    let name: String
    let otherUserEmail: String
    let latestMessage: LatestMessage
}

struct LatestMessage {
    let date : String
    let text : String
    let isRead: Bool
}
