//
//  NetworkManger.swift
//  NetworkApp
//
//  Created by Vladislav on 26.04.2021.
//

import UIKit
import Foundation
import Alamofire

class NetworkManager {

	static let shared = NetworkManager()

	private init() {}

	func fetchImage(with completion: @escaping (UIImage) -> Void) {
		guard let imageURL = URL(string: URLExamples.imageURL.rawValue) else { return }

		URLSession.shared.dataTask(with: imageURL) { (data, response, error) in

			if let error = error { print(error); return }
			if let response = response { print(response) }

			if let data = data, let image = UIImage(data: data) {
				completion(image)

			}
		}.resume()
	}

	func exampleOneButtonPressed(with completion: @escaping (Bool) -> Void) {
		guard let url = URL(string: URLExamples.exampleOne.rawValue) else { return }

		URLSession.shared.dataTask(with: url) { (data, _, _) in
			guard let data = data else { return }

			let decoder = JSONDecoder()
			decoder.keyDecodingStrategy = .convertFromSnakeCase

			do {
				let course = try decoder.decode(Course.self, from: data)
				print(course)
				completion(true)
			} catch let error {
				print(error.localizedDescription)
				completion(false)
			}

		}.resume()
	}

	func exampleTwoButtonPressed(with completion: @escaping (Bool) -> Void) {
		guard let url = URL(string: URLExamples.exampleTwo.rawValue) else { return }

		URLSession.shared.dataTask(with: url) { (data, _, _) in
			guard let data = data else { return }

			let decoder = JSONDecoder()
			decoder.keyDecodingStrategy = .convertFromSnakeCase

			do {
				let course = try decoder.decode([Course].self, from: data)
				print(course)
				completion(true)
			} catch let error {
				print(error.localizedDescription)
				completion(false)
			}

		}.resume()
	}

	func exampleThreeButtonPressed(with completion: @escaping (Bool) -> Void) {
		guard let url = URL(string: URLExamples.exampleThree.rawValue) else { return }

		URLSession.shared.dataTask(with: url) { (data, _, _) in
			guard let data = data else { return }

			let decoder = JSONDecoder()
			decoder.keyDecodingStrategy = .convertFromSnakeCase

			do {
				let websiteDescription = try decoder.decode(WebsiteDescription.self, from: data)
				print(websiteDescription)
				completion(true)
			} catch let error {
				print(error.localizedDescription)
				completion(false)
			}

		}.resume()
	}

	func exampleFourButtonPressed(with completion: @escaping (Bool) -> Void) {
		guard let url = URL(string: URLExamples.examoleFour.rawValue) else { return }

		URLSession.shared.dataTask(with: url) { (data, _, _) in
			guard let data = data else { return }

			let decoder = JSONDecoder()
			decoder.keyDecodingStrategy = .convertFromSnakeCase

			do {
				let websiteDescription = try decoder.decode(WebsiteDescription.self, from: data)
				print(websiteDescription)
				completion(true)
			} catch let error {
				print(error.localizedDescription)
				completion(false)
			}

		}.resume()
	}

	// Передача на сервер словаря
	/*
	private func postRequest() {
		let userData = ["Course": "Networking", "Lesson": "GET and POST"]
		guard let httpBody = try? JSONSerialization.data(withJSONObject: userData, options: []) else { return }
		request.httpBody = httpBody

			do {
				let json = try JSONSerialization.jsonObject(with: data, options: [])
	*/

	// Передача экземпляра модели
	func postRequest(with completion: @escaping (Bool) -> Void) {
		guard let url = URL(string: URLExamples.postRequest.rawValue) else { return }

		let course = CourseData(name: "Networking",
								imageUrl: "https://swiftbook.ru/wp-content/uploads/sites/2/2018/08/notifications-course-with-background.png",
								numberOfLessons: "18",
								numberOfTests: "10")

		guard let courseData = try? JSONEncoder().encode(course) else { return }

		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		request.httpBody = courseData

		URLSession.shared.dataTask(with: request) { (data, response, _) in
			guard let response = response, let data = data else { return }
			print(response)

			do {
				let course = try JSONDecoder().decode(CourseData.self, from: data)
				print(course)
				completion(true)
			} catch let error {
				print(error)
				completion(false)
			}
		}.resume()
	}

	func fetchCourses(with completion: @escaping ([Course]) -> Void) {
        guard let url = URL(string: URLExamples.exampleFive.rawValue) else { return }

		URLSession.shared.dataTask(with: url) { (data, _, _) in
			guard let data = data else { return }

			let decoder = JSONDecoder()

			do {
				let courses = try decoder.decode([Course].self, from: data)
				completion(courses)
			} catch let error {
				print(error.localizedDescription)
			}

		}.resume()
	}

	func alamofireGetButtonPressed(with completion: @escaping ([Course]) -> Void) {

		AF.request(URLExamples.exampleTwo.rawValue)
			.validate()
			.responseJSON { response in
				switch response.result {
				case .success(let value):
					completion(Course.getCourses(from: value) ?? [])
					print(value)
				case .failure(let error):
					print(error.localizedDescription)
				}
			}
	}

//	func alamofirePostButtonPressed(with completion: @escaping (Course) -> Void) {
//		let userData = [
//			"name": "Networking",
//			"imageUrl": "https://swiftbook.ru/wp-content/uploads/sites/2/2018/08/notifications-course-with-background.png",
//			"numberOfLessons": 18,
//			"numberOfTests": 10
//		] as [String: Any]
//
//		AF.request(URLExamples.postRequest.rawValue, method: .post, parameters: userData)
//			.validate()
//			.responseDecodable(of: Course.self) { response in
//				switch response.result {
//				case .success(let course):
//					print(course)
//					completion(course)
//				case .failure(let error):
//					print(error)
//				}
//		}
//	}
}
