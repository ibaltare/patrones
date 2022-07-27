//
//  SplashViewController.swift
//  DesignPatterns
//
//  Created by Nicolas on 25/07/22.
//

import UIKit

final class SplashViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !activityIndicator.isAnimating {
            activityIndicator.startAnimating()
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        activityIndicator.stopAnimating()
    }
    
    private func loadData(){
        let networkModel = NetworkModel.shared
        
        networkModel.getHeroes {  [weak self] heroes, error in
            
            guard let self = self else { return }
            
            if let msg = error {
                self.showAlert(title: "Error", message: msg)
                return
            }
            // TODO: erraglar
            networkModel.heroes = heroes
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                let homeStoryBoard = UIStoryboard(name: "Home", bundle: nil)
                guard let destination = homeStoryBoard.instantiateInitialViewController() else { return }
                self.navigationController?.setViewControllers([destination], animated: true)
            }
            
        }
    }
    
}

