//
//  FactController.swift
//  
//
//  Created by Jeremy Taylor on 11/1/22.
//

import Fluent
import Vapor

struct FactController: RouteCollection {
        func boot(routes: RoutesBuilder) throws {
                let facts = routes.grouped("facts")
                facts.get(use: index)
                facts.post(use: create)
                facts.put(use: update)
                facts.group(":factID") { fact in
                        fact.delete(use: delete)
                }
        }
        
        func index(req: Request) throws -> EventLoopFuture<[Fact]> {
                return Fact.query(on: req.db).all()
        }
        
        func create(req: Request) throws -> EventLoopFuture<HTTPStatus> {
                let fact = try req.content.decode(Fact.self)
                return fact.save(on: req.db).transform(to: .ok)
        }
        
        func update(req: Request) throws -> EventLoopFuture<HTTPStatus> {
                let fact = try req.content.decode(Fact.self)
                
                return Fact.find(fact.id, on: req.db)
                        .unwrap(or: Abort(.notFound))
                        .flatMap {
                                $0.fact = fact.fact
                                
                                return $0.update(on: req.db).transform(to: .ok)
                        }
        }
        
        func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
                Fact.find(req.parameters.get("factID"), on: req.db)
                        .unwrap(or: Abort(.notFound))
                        .flatMap { $0.delete(on: req.db) }
                        .transform(to: .ok)
        }
}

