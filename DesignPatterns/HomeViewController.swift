//
//  HomeViewController.swift
//  DesignPatterns
//
//  Created by Nicolas on 25/07/22.
//

import UIKit

final class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var heroes: [HeroModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Heroes"
        heroes = NetworkModel.shared.heroes
        configureViews()
    }
    
    private func configureViews() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.frame.width / 2) - 8,
               height: 200.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellView.cellIdentifier,
                                                      for: indexPath) as? CellView
        
        cell?.updateViews(data: heroes[indexPath.row])
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailStoryBoard = UIStoryboard(name: "Detail", bundle: nil)
        
        guard let destination = detailStoryBoard.instantiateInitialViewController() as? DetailViewController else { return }
        
        if indexPath.row < heroes.count {
            destination.data = heroes[indexPath.row]
        }
        
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: call Animation
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        cell.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row)) {
            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
}
