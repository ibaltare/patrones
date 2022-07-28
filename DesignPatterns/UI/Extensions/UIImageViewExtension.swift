//
//  UIImageViewExtension.swift
//  DesignPatterns
//
//  Created by Nicolas on 25/07/22.
//

import UIKit

typealias ImageCompletion = (UIImage?) -> Void

extension UIImageView {
  
    func setImage(url: URL) {
        downloadImageWithUrlSession(url: url) { [weak self] image in
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
  
    private func downloadImageWithUrlSession(url: URL, completion: ImageCompletion?) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else {
                completion?(nil)
                return
            }
            completion?(image)
        }.resume()
    }
    
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
  
}
