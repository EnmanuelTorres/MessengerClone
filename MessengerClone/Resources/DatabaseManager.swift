//
//  DatabaseManager.swift
//  MessengerClone
//
//  Created by ENMANUEL TORRES on 22/11/22.
//

import Foundation
import FirebaseDatabase

struct ChatAppUser{
    let firstName : String
    let lastName: String
    let emailAddress: String
    
    var safeEmail: String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    
    // let profilePictureUrl: String
}

final class DatabaseManager{
    
    static let shared = DatabaseManager()
    
    private let  database = Database.database().reference()
}

// MARK: - Account Management

extension DatabaseManager {
    
    
    public func userExists(with email: String,
                           completion: @escaping((Bool)-> Void)){
        
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
        })
    }
    
    /// Inserts new user to database
    public func insertUser ( user: ChatAppUser ){
        database.child(user.safeEmail).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
            
            
        ])
    }
}
