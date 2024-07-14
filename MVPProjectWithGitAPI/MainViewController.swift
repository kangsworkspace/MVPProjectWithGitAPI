//
//  ViewController.swift
//  MVPProjectWithGitAPI
//
//  Created by Healthy on 7/13/24.
//

import UIKit
import SafariServices

import SnapKit

protocol MainViewOutput: AnyObject {
    func bindPresenter(presenter: MainViewInput)
    func reloadTableView()
    func clearTextField()
    func showClearButton()
    func hideClearButton()
    func showWebPage(url: URL)
    func showEmptyView()
    func hideEmptyView()
}

class MainViewController: UIViewController {
    // MARK: - Field
    // 프레젠터
    private var presenter: MainViewInput
    
    // MARK: - Layouts
    private lazy var searchView = SearchView().then {
        $0.textField.delegate = self
        $0.textField.addTarget(self, action: #selector(textFieldChangeAction), for: .editingChanged)
        $0.searchButton.addTarget(self, action: #selector(searchButtonAction), for: .touchUpInside)
        $0.clearButton.addTarget(self, action: #selector(clearButtonAction), for: .touchUpInside)
    }
    
    private lazy var tableView = TableView().then {
        $0.tableView.dataSource = self
        $0.tableView.delegate = self
    }
    
    private var emptyView = EmptyView().then {
        $0.isHidden = true
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
        view.addSubview(emptyView)
        
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
        
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom).offset(40)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc private func searchButtonAction() {
        guard let text = searchView.textField.text else { return }
        presenter.searchUser(userID: text)
    }
    
    @objc private func clearButtonAction() {
        presenter.clearButtonTapped()
    }
    
    @objc private func textFieldChangeAction() {
        presenter.textFieldChanged(text: searchView.textField.text ?? "")
    }
    
    // 다른 화면을 눌렀을 때 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
    
    func clearTextField() {
        searchView.textField.text = ""
    }
    
    func showClearButton() {
        searchView.clearButton.isHidden = false
    }
    
    func hideClearButton() {
        searchView.clearButton.isHidden = true
    }
    
    func showWebPage(url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.modalPresentationStyle = .automatic
        self.present(safariViewController, animated: true)
    }
    
    func showEmptyView() {
        emptyView.isHidden = false
    }
    
    func hideEmptyView() {
        emptyView.isHidden = true
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let numberOfRows = tableView.numberOfRows(inSection: indexPath.section)
        
        if indexPath.row == numberOfRows - 4 {
            presenter.loadMoreUserInfo()
        }
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchView.textField.isFirstResponder {
            self.view.endEditing(true)
        } else {
            presenter.tableViewTapped(index: indexPath.row)
        }
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchButtonAction()
        return true
    }
}
