//
//  UserEntity.swift
//  Github
//
//  Created by Luis Manuel Ramirez Vargas on 21/05/17.
//  Copyright © 2017 Luis Manuel Ramirez Vargas. All rights reserved.
//

import Mapper

struct User: Mappable {
    
    let identifier: Int
    let login: String
    let avatar_url: String
    let url: String
    
    init(map: Mapper) throws {
        try identifier = map.from("id")
        try login = map.from("login")
        try avatar_url = map.from("avatar_url")
        try url = map.from("url")
    }
    
}
