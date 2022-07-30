//
//  SplashViewModel.swift
//  DesignPatterns
//
//  Created by Nicolas on 27/07/22.
//

import Foundation

protocol SplashViewModelProtocol {
    var heroData: [HeroModel] { get }
    func onViewLoaded()
}

final class SplashViewModel {
    
    weak var viewDelegate: SplashViewProtocol?
    private var heroes: [HeroModel] = []
    
    init( viewDelegate: SplashViewProtocol?){
        self.viewDelegate = viewDelegate
    }
    
    private func loadData(){
        let networkModel = NetworkModel.shared
        self.viewDelegate?.showLoading(true)
        networkModel.getHeroes {  [weak self] heroes, error in
            
            guard let self = self else { return }
            
            if let msg = error {
                self.viewDelegate?.showLoading(false)
                self.viewDelegate?.showMessage(message: msg)
                return
            }
            
            self.heroes = heroes
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) { [weak self] in
                self?.viewDelegate?.showLoading(false)
                self?.viewDelegate?.navigateToHome()
            }
            
        }
    }
}

extension SplashViewModel: SplashViewModelProtocol {
    var heroData: [HeroModel] {
        self.heroes
    }
    
    func onViewLoaded() {
        viewDelegate?.showLoading(true)
        loadData()
    }
    
}
