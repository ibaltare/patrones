//
//  CellView.swift
//  DesignPatterns
//
//  Created by Nicolas on 25/07/22.
//

import UIKit

final class CellView: UICollectionViewCell {
    
    static var cellIdentifier: String {
        String(describing: CellView.self)
    }
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellView.layer.cornerRadius = 4.0
        cellView.layer.shadowColor = UIColor.gray.cgColor
        cellView.layer.shadowOffset = CGSize.zero
        cellView.layer.shadowOpacity = 0.7
        cellView.layer.shadowRadius = 4.0
        cellImage.layer.cornerRadius = 4
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cellImage.image = nil
        cellTitle.text = nil
    }

    
    private func update(image: URL) {
        cellImage.setImage(url: image)
    }
    
    private func update(name: String?) {
        cellTitle.text = name
    }
    
    func updateViews(data: HeroModel) {
        update(image: data.photo)
        update(name: data.name)
    }
    
}
