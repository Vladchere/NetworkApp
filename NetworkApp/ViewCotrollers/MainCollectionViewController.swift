//
//  MainCollectionViewController.swift
//  NetworkApp
//
//  Created by Vladislav on 18.04.2021.
//

import UIKit

enum UserActions: String, CaseIterable {
	case downloadImage = "Download Image"
	case exampleOne = "Example One"
	case exampleTwo = "Example Two"
	case exampleThree = "Example Three"
	case exampleFour = "Example Four"
	case ourCourse = "Our Courses"
}

class MainCollectionViewController: UICollectionViewController {

	let userActions = UserActions.allCases

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		userActions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
													  for: indexPath) as! UserActionCollectionViewCell
    
        // Configure the cell
		let userAction = userActions[indexPath.row]
		cell.userActionLabel.text = userAction.rawValue
        return cell
    }

    // MARK: UICollectionViewDelegate
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let userAction = userActions[indexPath.item]

		switch userAction {
		case .downloadImage:
			performSegue(withIdentifier: "ShowImage", sender: nil)
		case .exampleOne:
			performSegue(withIdentifier: "ExampleOne", sender: nil)
		case .exampleTwo:
			performSegue(withIdentifier: "ExampleTwo", sender: nil)
		case .exampleThree:
			performSegue(withIdentifier: "ExampleThree", sender: nil)
		case .exampleFour:
			performSegue(withIdentifier: "ExampleFour", sender: nil)
		case .ourCourse:
			performSegue(withIdentifier: "OurCourses", sender: nil)
		}
	}

	// MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier != "ShowImage" {
			let courcesVC = segue.destination as! CourseTableViewController

			switch segue.identifier {
			case "ExampleOne":
				courcesVC.fetchDataV1()
			case "ExampleTwo":
				courcesVC.fetchDataV2()
			case "ExampleThree":
				courcesVC.fetchDataV3()
			case "ExampleFour":
				courcesVC.fetchDataV4()
			case "OurCourses":
				courcesVC.fetchData()
			default:
				break
			}
		}
	}
}

extension MainCollectionViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize {
		CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
	}
}
