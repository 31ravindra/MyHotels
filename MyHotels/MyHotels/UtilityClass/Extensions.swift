//
//  Extensions.swift
//  MyHotels
//
//  Created by Ravindra Patidar on 24/05/21.
//

import Foundation
import UIKit

extension UIImage {
    var jpeg: Data? { jpegData(compressionQuality: 1) }  // QUALITY min = 0 / max = 1
    var png: Data? { pngData() }
}

extension Data {
    var uiImage: UIImage? { UIImage(data: self) }
}
