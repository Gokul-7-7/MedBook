//
//  HomePageViewController.swift
//  MedBook
//
//  Created by Gokul on 17/08/23.
//

import UIKit
import Security

final class HomePageViewController: UIViewController {
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Assets.Font.degularMedium, size: 32)
        label.numberOfLines = 2
        label.text = "Which topic interests you today?"
        return label
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.titleLabel?.font = UIFont(name: Assets.Font.degularMedium, size: 22)
        button.setTitleColor(.systemRed, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .gray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for books"
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var sortParentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var sortButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var sortByLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Assets.Font.degularMedium, size: 18)
        label.numberOfLines = 1
        label.text = "Sort by:"
        return label
    }()
    
    private lazy var titleSortButton: UIButton = {
        let button = UIButton()
        button.setTitle("Title", for: .normal)
        button.titleLabel?.font = UIFont(name: Assets.Font.degularRegular, size: 18)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private lazy var averageSortButton: UIButton = {
        let button = UIButton()
        button.setTitle("Average", for: .normal)
        button.titleLabel?.font = UIFont(name: Assets.Font.degularRegular, size: 18)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private lazy var hitsSortButton: UIButton = {
        let button = UIButton()
        button.setTitle("Hits", for: .normal)
        button.titleLabel?.font = UIFont(name: Assets.Font.degularRegular, size: 18)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    var response: HomePageListResponse?
    private var titleString: String?
    var viewModel: HomePageViewModelProtocol
    var workItem : DispatchWorkItem?
    var selectedCountry: String?
    
    // MARK: - Initialiser
    init(viewModel: HomePageViewModelProtocol = HomePageViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configuration()
    }
    
    func registerCustomView() {
        tableView.register(UINib(nibName: "BookListTableViewCell", bundle: nil), forCellReuseIdentifier: "BookListTableViewCell")
    }
    
    // MARK: - Logout button action
    @objc func logoutButtonTapped() {
        if AuthTokenManager.removeAuthToken() {
            print("Auth token removed successfully")
            replaceRootViewController()
        } else {
            print("Failed to remove auth token")
            self.showToast(message: "Error while logging out")
        }
    }
    
    // MARK: - Sort button actions
    
    @objc func titleSortButtonTapped(_ sender: UIButton) {
        viewModel.currentSortOption = .title
        sender.isSelected = true
        if viewModel.currentSortOption == .title {
            titleSortButton.backgroundColor = .systemGray
            averageSortButton.backgroundColor = .clear
            hitsSortButton.backgroundColor = .clear
        } else {
            sender.backgroundColor = .clear
        }
        viewModel.sortDocs()
    }
    
    @objc func averageSortButtonTapped(_ sender: UIButton) {
        viewModel.currentSortOption = .ratingsAverage
        sender.isSelected = true
        if viewModel.currentSortOption == .ratingsAverage {
            titleSortButton.backgroundColor = .clear
            averageSortButton.backgroundColor = .systemGray
            hitsSortButton.backgroundColor = .clear
        } else {
            sender.backgroundColor = .clear
        }
        viewModel.sortDocs()
    }
    
    @objc func hitsSortButtonTapped(_ sender: UIButton) {
        viewModel.currentSortOption = .ratingsCount
        sender.isSelected = true
        if viewModel.currentSortOption == .ratingsCount {
            titleSortButton.backgroundColor = .clear
            averageSortButton.backgroundColor = .clear
            hitsSortButton.backgroundColor = .systemGray
        } else {
            sender.backgroundColor = .clear
        }
        viewModel.sortDocs()
    }
    
    // MARK: - Methods
    private func replaceRootViewController() {
        // Create a new instance of the view controller you want to set as root
        let newRootViewController: UIViewController = UINavigationController(rootViewController: LandingPageViewController())
        // Access the SceneDelegate
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            // Replace the root view controller of the scene's window
            if let window = sceneDelegate.window {
                window.rootViewController = newRootViewController
            }
        }
        self.showToast(message: "Logged Out Successfully")
    }
}

private extension HomePageViewController {
    
    func setupUI() {
        registerCustomView()
        setDelegateAndDataSource()
        setupNavigation()
        view.backgroundColor = .systemBackground
        setupConstraints()
        sortParentStackView.isHidden = true
    }
    
    func setupNavigation() {
        title = Copies.NavigationTitle.medBookTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesBackButton = true
        
        let bookMarkButton = UIBarButtonItem(image: UIImage(systemName: "bookmark.fill"), style: .plain, target: self, action: #selector(bookmarkButtonPressed))
        let logoutButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left.to.line"), style: .plain, target: self, action: #selector(logoutButtonTapped))
        navigationItem.rightBarButtonItems = [bookMarkButton, logoutButton]
    }
    
    @objc func bookmarkButtonPressed(_ sender: UIBarButtonItem) {
        let vc = BookMarkPageViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // MARK: - Constraints and view setup methods
    func setupConstraints() {
        setupActivityIndicatorConstraints()
        setupHeaderConstraints()
        setupSearchBarConstraints()
        setupSortBarConstraints()
        setupTableViewConstraints()
    }
    
    func setupActivityIndicatorConstraints() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        tableView.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor).isActive = true
    }
    
    func setupHeaderConstraints() {
        view.addSubview(headerLabel)
        headerLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: nil, height: nil, enableInsets: false)
    }
    
    func setupSearchBarConstraints() {
        view.addSubview(searchBar)
        searchBar.anchor(top: headerLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: nil, height: 50, enableInsets: false)
    }
    
    func setupSortBarConstraints() {
        setupParentStackViewConstraints()
        sortParentStackView.addArrangedSubview(sortByLabel)
        sortParentStackView.addArrangedSubview(sortButtonsStackView)
        setupSortButtonsStackView()
    }
    
    func setupParentStackViewConstraints() {
        view.addSubview(sortParentStackView)
        sortParentStackView.anchor(top: searchBar.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 8, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: nil, height: 30, enableInsets: false)
    }
    
    func setupSortButtonsStackView() {
        sortButtonsStackView.addArrangedSubview(titleSortButton)
        sortButtonsStackView.addArrangedSubview(averageSortButton)
        sortButtonsStackView.addArrangedSubview(hitsSortButton)
        titleSortButton.addTarget(self, action: #selector(titleSortButtonTapped), for: .touchUpInside)
        averageSortButton.addTarget(self, action: #selector(averageSortButtonTapped), for: .touchUpInside)
        hitsSortButton.addTarget(self, action: #selector(hitsSortButtonTapped), for: .touchUpInside)
    }
    
    func setupTableViewConstraints() {
        view.addSubview(tableView)
        tableView.anchor(top: sortParentStackView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: nil, height: nil, enableInsets: false)
    }
}
// MARK: - View model related methods
private extension HomePageViewController {
    func configuration() {
        initViewModel()
        observeEvent()
        setupUI()
    }
    
    func initViewModel() {
        viewModel.currentSortOption = .title
        viewModel.sortDocs()
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
                DispatchQueue.main.async {
                    self.sortParentStackView.isHidden = false
                    self.activityIndicator.startAnimating()
                }
            case .stopLoading:
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                }
            case .dataLoaded:
                self.response = self.viewModel.homePageListResponse
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.tableView.reloadData()
                    self.sortParentStackView.isHidden = false
                }
            case .error(let error):
                print(error ?? "Error in calling the country list api")
                DispatchQueue.main.async {
                    self.showToast(message: "Something went wrong!")
                }
            }
        }
    }
}

// MARK: - TableView Methods
extension HomePageViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        response?.docs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookListTableViewCell") as? BookListTableViewCell else { return UITableViewCell() }
        let doc = response?.docs?[indexPath.row]
        cell.setupViewWith(data: doc)
        cell.selectionStyle = .none
        return cell
    }
}

extension HomePageViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let doc = response?.docs?[indexPath.row], let coverI = doc.cover_i, let url = URL(string: "https://covers.openlibrary.org/b/id/\(coverI)-M.jpg") else { return }
        let viewModel = DetailPageViewModel(doc: doc)
        let viewController = BookDetailViewController(imageUrl: url, doc: doc, viewModel: viewModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - Search bar delegate
extension HomePageViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        workItem?.cancel()
        let newWorkItem = DispatchWorkItem {
            if searchText != "" {
                self.viewModel.onSearch(searchText: searchText)
            }
        }
        workItem = newWorkItem
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.7, execute: newWorkItem)
    }
    
}
