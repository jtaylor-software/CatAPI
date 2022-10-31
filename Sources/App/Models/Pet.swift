//
//  Pet.swift
//  
//
//  Created by Jeremy Taylor on 10/16/22.
//

import Fluent
import Vapor

final class Pet: Model, Content {
		static let schema = "pets"
		
		@ID(key: .id)
		var id: UUID?
		
		@Field(key: "name")
		var name: String
		
		@Field(key: "favoriteToy")
		var favoriteToy: String?
		@Field(key: "imageString")
		var imageString: String?
		@Field(key: "age")
		var age: Int
		@Field(key: "birthday")
		var birthday: String
		@Field(key: "trait")
		var trait: String
		
		init() { }
		
		init(id: UUID? = nil, name: String, favoriteToy: String? = nil, imageString: String? = nil, age: Int, birthday: String, trait: String) {
				self.id = id
				self.name = name
				self.favoriteToy = favoriteToy
				self.imageString = imageString
				self.age = age
				self.birthday = birthday
				self.trait = trait
		}
}
