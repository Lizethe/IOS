//
//  Client.swift
//  ClientRegistration
//
//  Created by Lizeth Ovando on 12/14/17.
//  Copyright © 2017 com.client.registration. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

class Client{
    @objc dynamic var id:String?
    @objc dynamic var name:String?
    @objc dynamic var lastName:String?
    @objc dynamic var photo:UIImage?
    @objc dynamic var phone:String?
    @objc dynamic var birthday:String?
    @objc dynamic var address: String;
    
    init?(id:String, name:String, lastName:String, photo:UIImage?, phone:String, birthday:String, address:String){
        self.id = id
        self.name = name
        self.photo = photo
        self.phone = phone
        self.birthday = birthday
        self.address = address

        if(name.isEmpty){
            return nil
        }
    }}
