//
//  ImageViewController.swift
//  NetworkApp
//
//  Created by Vladislav on 18.04.2021.
//

import UIKit

class ImageViewController: UIViewController {
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

		activityIndicator.startAnimating()
		activityIndicator.hidesWhenStopped = true
		fetchImage()
    }

	private func fetchImage() {
		let stringUrl = "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg"

		guard let imageURL = URL(string: stringUrl) else { return }

		URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
			if let error = error {print(error.localizedDescription); return}
			if let response = response {let httpResponse = response as! HTTPURLResponse; print(httpResponse.statusCode)}

			if let data = data, let image = UIImage(data: data) {
				DispatchQueue.main.async {
					self.activityIndicator.stopAnimating()
					self.imageView.image = image
				}
			}
		}.resume()
	}
}
