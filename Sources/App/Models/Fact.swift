//
//  Fact.swift
//  
//
//  Created by Jeremy Taylor on 11/1/22.
//

import Fluent
import Vapor

final class Fact: Model, Content {
    static let schema = "facts"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "fact")
    var fact: String
    
    init() { }
    
    init(id: UUID? = nil, fact: String) {
        self.id = id
        self.fact = fact
        
    }
}



