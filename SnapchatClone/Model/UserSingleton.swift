//
//  UserSingleton.swift
//  SnapchatClone
//
//  Created by Berk Gülşen on 12.10.2023.
//

import Foundation

class UserSingleton {
    
    static let sharedUserInfo = UserSingleton()
    
    var email = ""
    var username = ""
    
    private init() {
        
    }
}
