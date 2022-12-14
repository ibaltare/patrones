//
//  HomeViewModel.swift
//  DesignPatterns
//
//  Created by Nicolas on 29/07/22.
//

import Foundation

protocol HomeViewModelProtocol {
    var dataCount: Int { get }
    func data(for index: Int) -> HeroModel?
    func onItemSelected(at index: Int)
    func onViewLoaded()
}

final class HomeViewModel {
    private weak var viewDelegate: HomeViewControllerProtocol?
    private var heroes: [HeroModel] = []
    
    init(viewDelegate: HomeViewControllerProtocol, data: [HeroModel]){
        self.viewDelegate = viewDelegate
        heroes = data
    }
    
    private func loadData(){
        viewDelegate?.updateViews()
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    
    var dataCount: Int {
        heroes.count
    }
    
    func data(for index: Int) -> HeroModel? {
        guard index < dataCount else { return nil }
        return heroes[index]
    }
    
    func onItemSelected(at index: Int) {
        guard let data = data(for: index) else { return }
    
        viewDelegate?.navigateToDetail(with: data)
    }
    
    func onViewLoaded() {
        loadData()
    }
}
