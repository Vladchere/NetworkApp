//
//  Course.swift
//  NetworkApp
//
//  Created by Vladislav on 19.04.2021.
//

struct Course: Decodable {
	let name: String?
	let imageUrl: String?
	let number_of_lessons: Int?
	let number_of_tests: Int?
}

struct WebsiteDescription: Decodable {
	let courses: [Course]?
	let websiteDescription: String?
	let websiteName: String?
}
