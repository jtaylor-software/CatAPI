//
//  CreateFacts.swift
//  
//
//  Created by Jeremy Taylor on 11/1/22.
//

import Fluent

struct CreateFacts: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("facts")
            .id()
            .field("fact", .string, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("facts").delete()
    }
    
    
}
