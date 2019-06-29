/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Helpers for loading images and data.
*/

import Foundation
import CoreLocation
import UIKit
import SwiftUI


struct TicketsResponse: Decodable {
	var object: [TicketData]
	var error: Bool
	var errorMessage: String?
}

func load<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
	let data: Data

	guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
			else {
		fatalError("Couldn't find \(filename) in main bundle.")
	}

	do {
		data = try Data(contentsOf: file)
	} catch {
		fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
	}

	do {
		let decoder = JSONDecoder()
		return try decoder.decode(T.self, from: data)
	} catch {
		fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
	}
}

final class ImageStore {
	fileprivate typealias _ImageDictionary = [String: [Int: CGImage]]
	fileprivate var images: _ImageDictionary = [:]

	fileprivate static var originalSize = 250
	fileprivate static var scale = 2

	static var shared = ImageStore()

	func image(name: String, size: Int) -> Image {
		let index = _guaranteeInitialImage(name: name)

		let sizedImage = images.values[index][size]
				?? _sizeImage(images.values[index][ImageStore.originalSize]!, to: size * ImageStore.scale)
		images.values[index][size] = sizedImage

		return Image(sizedImage, scale: Length(ImageStore.scale), label: Text(verbatim: name))
	}

	static func loadImage(name: String) -> CGImage {
		guard
				let url = Bundle.main.url(forResource: name, withExtension: "jpg"),
				let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
				let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil)
				else {
			fatalError("Couldn't load image \(name).jpg from main bundle.")
		}
		return image
	}

	fileprivate func _guaranteeInitialImage(name: String) -> _ImageDictionary.Index {
		if let index = images.index(forKey: name) {
			return index
		}

		let image = ImageStore.loadImage(name: name)
		images[name] = [ImageStore.originalSize: image]
		return images.index(forKey: name)!
	}

	fileprivate func _sizeImage(_ image: CGImage, to size: Int) -> CGImage {
		guard
				let colorSpace = image.colorSpace,
				let context = CGContext(
						data: nil,
						width: size, height: size,
						bitsPerComponent: image.bitsPerComponent,
						bytesPerRow: image.bytesPerRow,
						space: colorSpace,
						bitmapInfo: image.bitmapInfo.rawValue)
				else {
			fatalError("Couldn't create graphics context.")
		}
		context.interpolationQuality = .high
		context.draw(image, in: CGRect(x: 0, y: 0, width: size, height: size))

		if let sizedImage = context.makeImage() {
			return sizedImage
		} else {
			fatalError("Couldn't resize image.")
		}
	}
}

//APPError enum which shows all possible errors
enum APPError: Error {
	case networkError(Error)
	case dataNotFound
	case jsonParsingError(Error)
	case invalidStatusCode(Int)
}

//Result enum to show success or failure
enum Result<T> {
	case success(T)
	case failure(APPError)
}

//dataRequest which sends request to given URL and convert to Decodable Object
func dataRequest<T: Decodable>(with url: String, objectType: T.Type, completion: @escaping (Result<T>) -> Void) {

	//create the url with NSURL
	let dataURL = URL(string: url)! //change the url

	//create the session object
	let session = URLSession.shared

	//now create the URLRequest object using the url object
	let request = URLRequest(url: dataURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)

	//create dataTask using the session object to send data to the server
	let task = session.dataTask(with: request, completionHandler: { data, response, error in

		guard error == nil else {
			completion(Result.failure(APPError.networkError(error!)))
			return
		}

		guard let data = data else {
			completion(Result.failure(APPError.dataNotFound))
			return
		}

		do {
			//create decodable object from data
			let decodedObject = try JSONDecoder().decode(objectType.self, from: data)
			completion(Result.success(decodedObject))
		} catch let error {
			completion(Result.failure(APPError.jsonParsingError(error as! DecodingError)))
		}
	})

	task.resume()
}
