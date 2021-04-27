//
//  MainViewController.swift
//  NetworkApp
//
//  Created by Vladislav on 18.04.2021.
//

import UIKit
import Alamofire

enum URLExamples: String {
	case imageURL = "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg"
	case exampleOne = "https://swiftbook.ru//wp-content/uploads/api/api_course"
	case exampleTwo = "https://swiftbook.ru//wp-content/uploads/api/api_courses"
	case exampleThree = "https://swiftbook.ru//wp-content/uploads/api/api_website_description"
	case examoleFour = "https://swiftbook.ru//wp-content/uploads/api/api_missing_or_wrong_fields"
	case exampleFive = "https://swiftbook.ru//wp-content/uploads/api/api_courses_capital"
	case postRequest = "https://jsonplaceholder.typicode.com/posts"
}

enum UserActions: String, CaseIterable {
	case downloadImage = "Download Image"
	case exampleOne = "Example One"
	case exampleTwo = "Example Two"
	case exampleThree = "Example Three"
	case exampleFour = "Example Four"
	case postRequest = "POST Request"
	case ourCourses = "Our Courses"
	case alamofireGet = "Alamofire GET"
	case alamofirePOST = "Alamofire POST"
}

class MainViewController: UICollectionViewController {

	let userActions = UserActions.allCases

	// MARK: UICollectionViewDataSource
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		userActions.count
	}

	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UserActionCell

		let userAction = userActions[indexPath.item]
		cell.userActionLabel.text = userAction.rawValue

		return cell
	}

	// MARK: UICollectionViewDelegate
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let userAction = userActions[indexPath.item]

		switch userAction {
		case .downloadImage: performSegue(withIdentifier: "ShowImage", sender: nil)
		case .exampleOne: NetworkManager.shared.exampleOneButtonPressed {(request) in self.showAlert(request)}
		case .exampleTwo: NetworkManager.shared.exampleTwoButtonPressed {(request) in self.showAlert(request)}
		case .exampleThree: NetworkManager.shared.exampleThreeButtonPressed {(request) in self.showAlert(request)}
		case .exampleFour: NetworkManager.shared.exampleFourButtonPressed {(request) in self.showAlert(request)}
		case .ourCourses: performSegue(withIdentifier: "OurCourses", sender: nil)
		case .postRequest: NetworkManager.shared.postRequest {(request) in self.showAlert(request)}
		case .alamofireGet: performSegue(withIdentifier: "AlamofireGet", sender: nil)
		case .alamofirePOST: performSegue(withIdentifier: "AlamofirePost", sender: nil)
		}
	}

	// MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier != "ShowImage" {

			let coursesVC = segue.destination as! CoursesViewController

			switch segue.identifier {
			case "OurCourses": coursesVC.showCourses()
			case "AlamofireGet": coursesVC.alamofireGetButtonPressed()
			case "AlamofirePost": coursesVC.alamofirePostButtonPressed()
			default: break
			}
		}
	}

	// MARK: - Private Methods
	private func showAlert(_ isRequest: Bool) {
		if isRequest {
			DispatchQueue.main.async {
				self.successAlert()
			}
		} else {
			DispatchQueue.main.async {
				self.failedAlert()
			}
		}
	}

	private func successAlert() {
		let alert = UIAlertController(title: "Success",
									  message: "You can see the results in the Debug aria",
									  preferredStyle: .alert)

		let okAction = UIAlertAction(title: "OK", style: .default)
		alert.addAction(okAction)
		present(alert, animated: true)
	}

	private func failedAlert() {
		let alert = UIAlertController(title: "Failed",
									  message: "You can see error in the Debug aria",
									  preferredStyle: .alert)

		let okAction = UIAlertAction(title: "OK", style: .default)
		alert.addAction(okAction)
		present(alert, animated: true)
	}

}

// MARK: - Extensions
extension MainViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
	}
}
