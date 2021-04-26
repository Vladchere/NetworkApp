//
//  Course.swift
//  NetworkApp
//
//  Created by Vladislav on 19.04.2021.
//

struct Course: Decodable {
	let name: String?
	let imageUrl: String?
    let numberOfLessons: Int?
    let numberOfTests: Int?
//	let numberOfLessons: String?
//	let numberOfTests: String?

//	init(dictCourse: [String: Any]) {
//		name = dictCourse["name"] as? String
//		imageUrl = dictCourse["imageUrl"] as? String
//		numberOfLessons = dictCourse["number_of_lessons"] as? String
//		numberOfTests = dictCourse["number_of_tests"] as? String
//	}

	enum CodingKeys: String, CodingKey {
		case name = "Name"
		case imageUrl = "ImageUrl"
		case numberOfLessons = "Number_of_lessons"
		case numberOfTests = "Number_of_tests"
	}

//	static func getCourses(from value: Any) -> [Course]? {
//		guard let value = value as? [[String: Any]] else { return nil }
//		return value.compactMap { Course(dictCourse: $0) }
//	}
}

struct CourseData: Codable {
	let name: String?
	let imageUrl: String?
	let numberOfLessons: String?
	let numberOfTests: String?
}

struct WebsiteDescription: Decodable {
	let courses: [Course]?
	let websiteDescription: String?
	let websiteName: String?
}
