//
//  UIImageView+SetImage.swift
//  OfficeeApp
//
//  Created by Valeriy L on 09.10.2022.
//

import UIKit
import Kingfisher

extension UIImageView {
  
  /// Loads and sets image resource with provided url and placeholder.
  /// - Parameters:
  ///   - urlString: image resource url string
  ///   - placeholder: a substitute of image when image resource for `urlString` is not available
  func setImage(
    with urlString: String?,
    placeholder: UIImage? = nil
  ) {
    kf.cancelDownloadTask()

    let processor = DownsamplingImageProcessor(size: bounds.size)
    var kfOptions: KingfisherOptionsInfo = [
      .processor(processor),
      .loadDiskFileSynchronously,
      .cacheOriginalImage,
      .transition(.fade(0.25))
    ]
    var resourceURL: URL?
    if let urlString = urlString,
      let url = URL(string: urlString) {
      resourceURL = url
      kfOptions.append(.lowDataMode(.network(url)))
    } else {
      image = placeholder
    }

    kf.indicatorType = .activity

    kf.setImage(
      with: resourceURL,
      placeholder: placeholder,
      options: kfOptions)
  }
}
