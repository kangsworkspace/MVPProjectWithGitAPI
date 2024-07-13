//
//  ViewController.swift
//  MVPProjectWithGitAPI
//
//  Created by Healthy on 7/13/24.
//

import UIKit

protocol MainViewOutput: AnyObject {
    func bindPresenter(presenter: MainViewInput)
    func reloadTableView()
}

class MainViewController: UIViewController {
    // MARK: - Field
    // 프레젠터
    private var presenter: MainViewInput
    
    // MARK: - Layouts
    private lazy var searchView = SearchView().then {
        $0.textField.delegate = self
        $0.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    private lazy var tableView = TableView().then {
        $0.tableView.dataSource = self
        $0.tableView.delegate = self
    }
    
    // MARK: - Life Cycles
    // 의존성 주입
    init(presenter: MainViewInput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        bindPresenter(presenter: presenter)
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
    
    @objc func searchButtonTapped() {
        guard let text = searchView.textField.text else { return }
        presenter.searchUser(userID: text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions
extension MainViewController: MainViewOutput {
    func bindPresenter(presenter: any MainViewInput) {
        presenter.bindView(view: self)
    }
    
    func reloadTableView() {
        tableView.tableView.reloadData()
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getNumberOfUserInfos()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.id, for: indexPath) as! TableViewCell
        cell.selectionStyle = .none
        let userInfos = presenter.getUserInfos()
        cell.setConfig(name: userInfos[indexPath.row].login, urlString: userInfos[indexPath.row].url)
        cell.setImage(with: userInfos[indexPath.row].avatarURL)
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchButtonTapped()
        return true
    }
}
