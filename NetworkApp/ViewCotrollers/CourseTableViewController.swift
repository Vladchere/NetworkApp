//
//  CourseTableViewController.swift
//  NetworkApp
//
//  Created by Vladislav on 18.04.2021.
//

import UIKit

class CourseTableViewController: UITableViewController {

	private let jsonUrlOne = "https://swiftbook.ru//wp-content/uploads/api/api_course"
	private let jsonUrlTwo = "https://swiftbook.ru//wp-content/uploads/api/api_courses"
	private let jsonUrlThree = "https://swiftbook.ru//wp-content/uploads/api/api_website_description"
	private let jsonUrlFour = "https://swiftbook.ru//wp-content/uploads/api/api_missing_or_wrong_fields"

	private var courses: [Course] = []


    override func viewDidLoad() {
        super.viewDidLoad()

		tableView.rowHeight = 100
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		courses.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CourseTableViewCell

		let course = courses[indexPath.row]
		cell.configure(with: course)

        return cell
    }

	func fetchDataV1() {
		guard let url = URL(string: self.jsonUrlOne) else { return }

		URLSession.shared.dataTask(with: url) { (data, _, _) in
			guard let data = data else { return }

			let decoder = JSONDecoder()

			do {
				let course = try decoder.decode(Course.self, from: data)
				print(course)
			} catch let error {
				print(error.localizedDescription)
			}
			
		}.resume()
	}

	func fetchDataV2() {
		guard let url = URL(string: jsonUrlTwo) else { return }

		URLSession.shared.dataTask(with: url) { (data, _, _) in
			guard let data = data else { return }

			let decoder = JSONDecoder()

			do {
				let courses = try decoder.decode([Course].self, from: data)
				print(courses)
			} catch let error {
				print(error.localizedDescription)
			}

		}.resume()
	}

	func fetchDataV3() {
		guard let url = URL(string: jsonUrlThree) else { return }

		URLSession.shared.dataTask(with: url) { (data, _, _) in
			guard let data = data else { return }

			let decoder = JSONDecoder()

			do {
				let websiteDescription = try decoder.decode(WebsiteDescription.self, from: data)
				print(websiteDescription)
			} catch let error {
				print(error.localizedDescription)
			}

		}.resume()
	}

	func fetchDataV4() {
		guard let url = URL(string: jsonUrlFour) else { return }

		URLSession.shared.dataTask(with: url) { (data, _, _) in
			guard let data = data else { return }

			let decoder = JSONDecoder()

			do {
				let websiteDescription = try decoder.decode(WebsiteDescription.self, from: data)
				print(websiteDescription)
			} catch let error {
				print(error)
			}

		}.resume()
	}

	func fetchData() {
		guard let url = URL(string: jsonUrlTwo) else { return }

		URLSession.shared.dataTask(with: url) { (data, _, _) in
			guard let data = data else { return }

			let decoder = JSONDecoder()

			do {
				self.courses = try decoder.decode([Course].self, from: data)
			} catch let error {
				print(error.localizedDescription)
			}

		}.resume()
	}
}
