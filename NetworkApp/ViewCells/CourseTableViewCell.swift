//
//  CourseTableViewCell.swift
//  NetworkApp
//
//  Created by Vladislav on 18.04.2021.
//

import UIKit

class CourseTableViewCell: UITableViewCell {

	@IBOutlet weak var courseImageView: UIImageView!
	@IBOutlet weak var nameCourseLabel: UILabel!
	@IBOutlet weak var numberLessonsCourseLabel: UILabel!
	@IBOutlet weak var numberTestsCourseLabel: UILabel!

	func configure(with course: Course) {
		nameCourseLabel.text = course.name
		numberLessonsCourseLabel.text = "Number of lesson: \(course.number_of_lessons ?? 0)"
		numberTestsCourseLabel.text = "Number of tests: \(course.number_of_tests ?? 0)"

		DispatchQueue.global().async {
			guard let stringURL = course.imageUrl else { return }
			guard let imageURL = URL(string: stringURL) else { return }
			guard let imageData = try? Data(contentsOf: imageURL) else { return }

			DispatchQueue.main.async {
				self.courseImageView.image = UIImage(data: imageData)
			}
		}
	}
}
