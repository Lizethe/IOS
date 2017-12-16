//
//  ClientDB.swift
//  ClientRegistration
//
//  Created by Lizeth Ovando on 12/14/17.
//  Copyright © 2017 com.client.registration. All rights reserved.
//

import Foundation
import RealmSwift

class ClientDB: Object{
    
    @objc dynamic var id:String?
    @objc dynamic var name:String?
    @objc dynamic var lastName:String?
    @objc dynamic var photo:NSData?
    @objc dynamic var phone:String?
    @objc dynamic var birthday:String?
    @objc dynamic var address: String?
    		
    override static func primaryKey() -> String?{
        return "id"
        
    }
}

