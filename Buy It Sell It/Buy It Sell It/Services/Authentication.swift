//
//  Authentication.swift
//  Buy It Sell It
//
//  Created by Asil Arslan on 20.01.2018.
//  Copyright © 2018 Asil Arslan. All rights reserved.
//

import Foundation

class Authentication {
    struct defaultsKeys {
        static let keyAuthenticate = "authenticateKey"
    }
    
    static func login(){
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: defaultsKeys.keyAuthenticate)
    }
    
    static func logout(){
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: defaultsKeys.keyAuthenticate)
    }
    
    static func isLogin() -> Bool{
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: defaultsKeys.keyAuthenticate)
    }
}
