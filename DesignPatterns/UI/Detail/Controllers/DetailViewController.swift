//
//  DetailViewController.swift
//  DesignPatterns
//
//  Created by Nicolas on 27/07/22.
//

import UIKit

protocol DetailViewControllerProtocol: AnyObject {
    
    func update(image: URL)
    func update(description: String?)
    func update(name: String?)
}

final class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var contentImageView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentImageHeight: NSLayoutConstraint!
    @IBOutlet weak var contentImageWidth: NSLayoutConstraint!
    
    var viewModel: DetailViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        viewModel?.onViewLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        round()
        showAnimation()
    }
    
    private func round(){
        contentImageView.layer.cornerRadius =  contentImageView.bounds.width / 2
        imageView.layer.cornerRadius =  imageView.bounds.width / 2
    }
    
    private func showAnimation() {
        contentImageView.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(
            withDuration: 1,
            delay: 0,
            usingSpringWithDamping: 0.55,
            initialSpringVelocity: 0,
            options: []) {
                self.contentImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            } completion: { _ in }
        
    }
}

extension DetailViewController: DetailViewControllerProtocol {
    
    func update(image: URL) {
        imageView.setImage(url: image)
    }
    
    func update(name: String?) {
        nameLabel.text = name
    }
    
    func update(description: String?) {
        descriptionTextView.text = description
    }
}

extension DetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let correctedOffset = scrollView.contentOffset.y + view.safeAreaInsets.top
        contentImageHeight.constant = 240.0 - correctedOffset
        contentImageWidth.constant = contentImageHeight.constant
        round()
    }
    
}
