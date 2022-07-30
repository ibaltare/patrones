//
//  DetailViewModel.swift
//  DesignPatterns
//
//  Created by Nicolas on 29/07/22.
//

import Foundation

protocol DetailViewModelProtocol {
    
    func onViewLoaded()
}

final class DetailViewModel {
    
    private weak var viewDelegate: DetailViewControllerProtocol?
    private var heroData: HeroModel
    
    init(data: HeroModel, viewDelegate: DetailViewControllerProtocol){
        heroData = data
        self.viewDelegate = viewDelegate
    }
    
}

extension DetailViewModel: DetailViewModelProtocol {
    
    func onViewLoaded() {
        viewDelegate?.update(image: heroData.photo)
        viewDelegate?.update(name: heroData.name)
        viewDelegate?.update(description: heroData.description)
    }
    
}
