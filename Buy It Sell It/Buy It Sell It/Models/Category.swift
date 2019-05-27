//
//  Category.swift
//  Buy It Sell It
//
//  Created by Asil Arslan on 28.12.2017.
//  Copyright © 2017 Asil Arslan. All rights reserved.
//

import Foundation
class Category{
    var id:Int!
    var icon:String!
    var name:String!
    var numberOfItems:Int!
    var categoryDescription:String!
    var category:Category!
    var categories:[Category]
    
    init(id:Int,icon:String,name:String,numberOfItems:Int,categoryDescription:String,categories:[Category]) {
        self.id=id
        self.icon=icon
        self.name=name
        self.numberOfItems=numberOfItems
        self.categoryDescription=categoryDescription
        self.categories=categories
    }
    
    init(id:Int,icon:String,name:String,numberOfItems:Int,categoryDescription:String,category:Category?,categories:[Category]) {
        self.id=id
        self.icon=icon
        self.name=name
        self.numberOfItems=numberOfItems
        self.categoryDescription=categoryDescription
        self.category=category
        self.categories=categories
    }
}
