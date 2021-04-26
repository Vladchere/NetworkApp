//
//  ImageViewController.swift
//  NetworkApp
//
//  Created by Vladislav on 18.04.2021.
//

import UIKit

class ImageViewController: UIViewController {

	@IBOutlet var imageView: UIImageView!
	@IBOutlet var activityIndicator: UIActivityIndicatorView!

	override func viewDidLoad() {
		super.viewDidLoad()

		activityIndicator.startAnimating()
		activityIndicator.hidesWhenStopped = true

		NetworkManager.shared.fetchImage() { image in
			DispatchQueue.main.async {
				self.activityIndicator.stopAnimating()
				self.imageView.image = image
			}
		}
	}
}
