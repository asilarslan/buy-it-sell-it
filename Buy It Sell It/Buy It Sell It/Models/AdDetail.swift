//
//  AdDetail.swift
//  Buy It Sell It
//
//  Created by Asil Arslan on 1.01.2018.
//  Copyright © 2018 Asil Arslan. All rights reserved.
//

import Foundation

class AdDetail{
    var id:Int!
    var type:String!
    var name:String!
    var display:String
    var value:String!
    var items:[Selection]!
    
    init(id:Int,display:String,value:String) {
        self.id = id
        self.display = display
        self.value = value
    }
    
    init(id:Int,type:String,name:String,display:String) {
        self.id = id
        self.type = type
        self.name = name
        self.display = display
    }
    
    init(id:Int,type:String,name:String,display:String,items:[Selection]) {
        self.id = id
        self.type = type
        self.name = name
        self.display = display
        self.items = items
    }
    
}
