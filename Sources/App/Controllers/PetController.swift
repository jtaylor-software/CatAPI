//
//  PetController.swift
//  
//
//  Created by Jeremy Taylor on 10/16/22.
//

import Fluent
import Vapor

struct PetController: RouteCollection {
		func boot(routes: RoutesBuilder) throws {
				let pets = routes.grouped("pets")
				pets.get(use: index)
				pets.post(use: create)
				pets.put(use: update)
				pets.group(":petID") { pet in
						pet.delete(use: delete)
				}
		}
		
		func index(req: Request) throws -> EventLoopFuture<[Pet]> {
				return Pet.query(on: req.db).all()
		}
		
		func create(req: Request) throws -> EventLoopFuture<HTTPStatus> {
				let pet = try req.content.decode(Pet.self)
				return pet.save(on: req.db).transform(to: .ok)
		}
		
		func update(req: Request) throws -> EventLoopFuture<HTTPStatus> {
				let pet = try req.content.decode(Pet.self)
				
				return Pet.find(pet.id, on: req.db)
						.unwrap(or: Abort(.notFound))
						.flatMap {
								$0.favoriteToy = pet.favoriteToy
								$0.imageData = pet.imageData
								$0.trait = pet.trait
								return $0.update(on: req.db).transform(to: .ok)
						}
		}
		
		func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
				Pet.find(req.parameters.get("petID"), on: req.db)
						.unwrap(or: Abort(.notFound))
						.flatMap { $0.delete(on: req.db) }
						.transform(to: .ok)
		}
}
