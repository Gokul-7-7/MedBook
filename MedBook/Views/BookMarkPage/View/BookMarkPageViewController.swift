//
//  BookMarkPageViewController.swift
//  MedBook
//
//  Created by Gokul on 02/09/23.
//

import UIKit

final class BookMarkPageViewController: UITableViewController {
    
    var viewModel: BookMarkPageViewModel
    var list: [Doc]?
    
    init(viewModel: BookMarkPageViewModel = BookMarkPageViewModel(), list: [Doc]? = nil) {
        self.viewModel = viewModel
        self.list = list
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookListTableViewCell") as? BookListTableViewCell else { return UITableViewCell() }
        let doc = list?[indexPath.row]
        cell.setupBookMarkViewWith(tag: indexPath.row,isBookMarked: true, data: doc, delegate: self)
        cell.selectionStyle = .none
        return cell
    }
}

private extension BookMarkPageViewController {
    
    func configuration() {
        title = "Bookmarks"
        registerCustomView()
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.observer = self
        initViewModel()
        observeEvent()
    }
    
    func registerCustomView() {
        tableView.register(UINib(nibName: "BookListTableViewCell", bundle: nil), forCellReuseIdentifier: "BookListTableViewCell")
    }
    
    func initViewModel() {
        viewModel.onViewDidLoad()
    }
    
    func setDelegateAndDataSource() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func observeEvent() {
        viewModel.eventHandler = { [weak self]event in
            guard let self else { return }
            switch event {
            case .loading:
                print("Loading")
            case .stopLoading:
                print("stop loading")
            case .dataLoaded:
                self.list = self.viewModel.list
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .error(let error):
                print(error ?? "Error while retrieving bookmark list")
                DispatchQueue.main.async {
                    self.showToast(message: "Something went wrong!")
                }
            }
        }
    }
}

// MARK: - ViewModel observer methods
extension BookMarkPageViewController: BookMarkPageViewModelObserver {
    func dataLoaded(list: [Doc]?) {
        self.list = list
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
}

// MARK: - Custom cell Delegate methods
extension BookMarkPageViewController: BookListTableViewCellDelegate {
    func bookMarkButtonPressed(key: String) {
        viewModel.removeAt(key: key)
    }
}
