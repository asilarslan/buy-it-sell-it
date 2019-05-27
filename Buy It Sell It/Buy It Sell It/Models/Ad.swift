//
//  Ad.swift
//  Buy It Sell It
//
//  Created by Asil Arslan on 31.12.2017.
//  Copyright © 2017 Asil Arslan. All rights reserved.
//

import Foundation
import UIKit

class Ad{
    var id:Int!
    var imageUrls:[String]?
    var images:[UIImage]?
    var name:String!
    var location:String!
    var price:Double!
    var adDescription:String!
    var contactType:Int!
    var createdBy: User!
    
    init(id:Int,images:[UIImage],name:String,location:String,price:Double,adDescription:String,contactType:Int,createdBy: User) {
        self.id = id
        self.images = images
        self.name = name
        self.location = location
        self.price = price
        self.adDescription = adDescription
        self.contactType = contactType
        self.createdBy = createdBy
    }
    
    init(id:Int,imageUrls:[String],name:String,location:String,price:Double,adDescription:String,createdBy: User) {
        self.id = id
        self.imageUrls = imageUrls
        self.name = name
        self.location = location
        self.price = price
        self.adDescription = adDescription
        self.createdBy = createdBy
    }
    
    init(id:Int,imageUrls:[String],name:String,location:String,price:Double,adDescription:String,contactType:Int,createdBy: User) {
        self.id = id
        self.imageUrls = imageUrls
        self.name = name
        self.location = location
        self.price = price
        self.adDescription = adDescription
        self.contactType = contactType
        self.createdBy = createdBy
    }

}
