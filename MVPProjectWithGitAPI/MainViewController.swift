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
    
    private lazy var tableView = TableView().then {
        $0.tableView.dataSource = self
        $0.tableView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    // MARK: - Functions
    private func setUI() {
        view.backgroundColor = .white

        view.addSubview(searchView)
        view.addSubview(tableView)
        
        searchView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(15)
            make.top.equalTo(searchView.snp.bottom).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-15)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.id, for: indexPath) as! TableViewCell
        cell.selectionStyle = .none
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
