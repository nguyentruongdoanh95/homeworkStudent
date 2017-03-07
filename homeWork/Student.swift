//
//  Student.swift
//  homeWork
//
//  Created by Godfather on 3/7/17.
//  Copyright © 2017 Godfather. All rights reserved.
//

import UIKit

class Student: NSObject, NSCoding {
    var name: String!
    var age: String!
    var phoneNumber: String!
    
    
    struct PropertyKey {
        static let name = "name"
        static let age = "age"
        static let phoneNumber = "phoneNumber"
    }
    
    init(name: String, age: String, phoneNumber: String) {
        self.name = name
        self.age = age
        self.phoneNumber = phoneNumber
    }
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: PropertyKey.name) as! String
        let age = aDecoder.decodeObject(forKey: PropertyKey.age) as! String
        let phoneNumber = aDecoder.decodeObject(forKey: PropertyKey.phoneNumber) as! String
        
        self.init(name: name, age: age, phoneNumber: phoneNumber)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(age, forKey: PropertyKey.age)
        aCoder.encode(phoneNumber, forKey: PropertyKey.phoneNumber)
    }
}
