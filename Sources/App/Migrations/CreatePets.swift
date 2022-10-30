//
//  CreatePets.swift
//  
//
//  Created by Jeremy Taylor on 10/16/22.
//

import Fluent

struct CreatePets: Migration {
		func prepare(on database: Database) -> EventLoopFuture<Void> {
				return database.schema("pets")
						.id()
						.field("name", .string, .required)
						.field("favoriteToy", .string)
						.field("imageData", .data)
						.field("age", .int, .required)
						.field("birthday", .string, .required)
						.field("trait", .string, .required)
						.create()
		}
		
		func revert(on database: Database) -> EventLoopFuture<Void> {
				return database.schema("pets").delete()
		}
		
		
}
