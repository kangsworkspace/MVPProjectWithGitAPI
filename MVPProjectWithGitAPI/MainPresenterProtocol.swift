//
//  MainPresenter.swift
//  MVPProjectWithGitAPI
//
//  Created by Healthy on 7/13/24.
//

import Foundation

protocol MainPresenterProtocol {
    func bindView(view: MainViewProtocol)
}

final class MainPresenter {
    // MARK: - Field
    weak var view: MainViewProtocol?
    private var networkProvider = NetworkProvider.shared
    
    // MARK: - Life Cycles
    init() {
        networkProvider.login()
    }
}

// MARK: - Extensions
extension MainPresenter: MainPresenterProtocol {
    // MARK: - Functions
    func bindView(view: any MainViewProtocol) {
        self.view = view
    }
}
