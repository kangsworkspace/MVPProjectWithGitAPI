//
//  ViewController.swift
//  MVPProjectWithGitAPI
//
//  Created by Healthy on 7/13/24.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Layouts
    private lazy var searchView = SearchView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    // MARK: - Functions
    private func setUI() {
        view.backgroundColor = .white

        view.addSubview(searchView)
        
        searchView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
}
