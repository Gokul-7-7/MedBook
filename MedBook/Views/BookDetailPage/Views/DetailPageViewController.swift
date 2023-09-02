//
//  DetailPageViewController.swift
//  MedBook
//
//  Created by Gokul on 01/09/23.
//

import UIKit
import Kingfisher

final class BookDetailViewController: UIViewController {
    
    private lazy var headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Assets.Font.degularBold, size: 24)
        label.numberOfLines = 2
        label.textColor = Assets.Colors.backgroundColorBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Assets.Font.degularBold, size: 18)
        label.textColor = Assets.Colors.backgroundColorBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Assets.Font.degularBold, size: 18)
        label.textColor = Assets.Colors.backgroundColorBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: Assets.Font.degularRegular, size: 18)
        textView.textColor = .systemGray
        textView.isEditable = false
        return textView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .gray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    var imageUrl: URL
    var doc: Doc
    var viewModel: DetailPageViewModelProtocol
    var detailPageResponse: BookDetailResponse?
    var isBookMarked: Bool = false
    
    init(imageUrl: URL, doc: Doc, viewModel: DetailPageViewModelProtocol) {
        self.imageUrl = imageUrl
        self.doc = doc
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let key = doc.key {
            self.isBookMarked = BookMarkDataManager.shared.isDocEntityPresent(withKey: key)
            viewModel.isBookMarked = self.isBookMarked
        }
        viewModel.observer = self
        view.backgroundColor = .systemBackground
        configuration()
    }
}

// MARK: - ViewModel handler methods

private extension BookDetailViewController {
    
    func configuration() {
        initViewModel()
        observeEvent()
        setupUI()
        setupView()
    }
    
    func setupView() {
        titleLabel.text = viewModel.doc?.title
        headerImageView.kf.setImage(with: imageUrl)
        authorLabel.text = doc.author_name?.first
    }
    
    func initViewModel() {
        viewModel.onViewDidLoad()
    }
    
    func observeEvent() {
        viewModel.eventHandler = { [weak self]event in
            guard let self else { return }
            switch event {
            case .loading:
                DispatchQueue.main.async {
                    self.activityIndicator.startAnimating()
                }
            case .stopLoading:
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                }
            case .dataLoaded:
                self.detailPageResponse = self.viewModel.detailPageResponse
                DispatchQueue.main.async {
                    self.descriptionTextView.text = self.detailPageResponse?.description
                    self.dateLabel.text = self.detailPageResponse?.firstPublishDate
                    self.activityIndicator.stopAnimating()
                }
            case .error(let error):
                print(error ?? "Error in calling the detail page api")
                DispatchQueue.main.async {
                    self.showToast(message: "Something went wrong!")
                }
            }
        }
    }
}

// MARK: - View model observer methods
extension BookDetailViewController: DetailPageViewModelObserver {
    
    func bookMark(isBookMarked: Bool) {
        self.isBookMarked = isBookMarked
        print(isBookMarked)
    }
    
    func bookMarkStatus(result: Bool) {
        if !result {
            showToast(message: "Failure!")
        }
    }
}

// MARK: - UI setup
private extension BookDetailViewController {
    
    func setupUI() {
        setupNavigation()
        setupConstraints()
    }
    
    func setupNavigation() {
        if self.isBookMarked {
            let bookMarkButtonFill = UIBarButtonItem(image:  UIImage(systemName: "bookmark.fill"), style: .plain, target: self, action: #selector(bookMarkButtonPressed))
            navigationItem.rightBarButtonItems = [bookMarkButtonFill]
        } else {
            let bookMarkButton = UIBarButtonItem(image:  UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(bookMarkButtonPressed))
            navigationItem.rightBarButtonItems = [bookMarkButton]
        }
    }
    
    @objc func bookMarkButtonPressed(_ sender: UIBarButtonItem) {
        viewModel.isBookmarkPressed()
        if isBookMarked {
            sender.image = UIImage(systemName: "bookmark.fill")
        } else {
            sender.image = UIImage(systemName: "bookmark")
        }
    }
    
    func setupConstraints() {
        setupActivityIndicator()
        setupImageViewConstraits()
        setupTitleViewConstraints()
        setupAuthorLabelConstraints()
        setupDateLabelConstraints()
        setupDescriptionViewConstraints()
    }
    
    func setupActivityIndicator() {
        descriptionTextView.addSubview(activityIndicator)
        activityIndicator.centerYAnchor.constraint(equalTo: descriptionTextView.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: descriptionTextView.centerXAnchor).isActive = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupImageViewConstraits() {
        view.addSubview(headerImageView)
        headerImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 8, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: nil, height: 150, enableInsets: false)
    }
    
    func setupTitleViewConstraints() {
        view.addSubview(titleLabel)
        titleLabel.anchor(top: headerImageView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 8, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: nil, height: nil, enableInsets: false)
    }
    
    func setupAuthorLabelConstraints() {
        view.addSubview(authorLabel)
        authorLabel.anchor(top: titleLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, paddingTop: 8, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: nil, height: 20, enableInsets: false)
    }
    
    func setupDateLabelConstraints() {
        view.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.leadingAnchor.constraint(greaterThanOrEqualTo: authorLabel.trailingAnchor, constant: 8).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: authorLabel.centerYAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func setupDescriptionViewConstraints() {
        view.addSubview(descriptionTextView)
        descriptionTextView.anchor(top: authorLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 8, paddingLeft: 16, paddingBottom: 8, paddingRight: 16, width: nil, height: nil, enableInsets: false)
    }
}


