//
//  SplashViewController.swift
//  DesignPatterns
//
//  Created by Nicolas on 25/07/22.
//

import UIKit

protocol SplashViewProtocol: AnyObject {
    func showLoading(_ show: Bool)
    func navigateToHome()
    func showMessage(message: String)
}

final class SplashViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var viewModel: SplashViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SplashViewModel(viewDelegate: self)
        viewModel?.onViewLoaded()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        activityIndicator.stopAnimating()
    }
    
}

extension SplashViewController: SplashViewProtocol {
    
    func showLoading(_ show: Bool) {
        switch show {
            case true where !activityIndicator.isAnimating:
                activityIndicator.startAnimating()
            case false where activityIndicator.isAnimating:
                activityIndicator.stopAnimating()
            default:
                break
        }
    }
    
    func navigateToHome() {
        let homeStoryBoard = UIStoryboard(name: "Home", bundle: nil)
        guard let data = viewModel?.heroData,
            let destination = homeStoryBoard.instantiateInitialViewController() as? HomeViewController else { return }
        destination.viewModel = HomeViewModel(viewDelegate: destination, data: data)
        self.navigationController?.setViewControllers([destination], animated: true)
    }
    
    func showMessage(message: String) {
        self.showAlert(title: "Error", message: message)
    }
    
}

