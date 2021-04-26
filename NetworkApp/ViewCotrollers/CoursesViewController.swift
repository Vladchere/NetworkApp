//
//  CoursesViewController.swift
//  NetworkApp
//
//  Created by Vladislav on 18.04.2021.
//

import UIKit

class CoursesViewController: UITableViewController {

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
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CourseCell

		let course = courses[indexPath.row]
		cell.configure(with: course)

		return cell
	}

	func showCourses() {
		NetworkManager.shared.fetchCourses { (courses) in
			DispatchQueue.main.async {
				self.courses = courses
				self.tableView.reloadData()
			}
		}
	}

	func alamofireGetButtonPressed() {
		NetworkManager.shared.alamofireGetButtonPressed { (courses) in
			DispatchQueue.main.async {
				self.courses = courses
				self.tableView.reloadData()
			}
		}
	}

	func alamofirePostButtonPressed() {
	}
}
