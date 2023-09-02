//
//  BookDetailViewController.swift
//  MedBook
//
//  Created by Gokul on 01/09/23.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    lazy var headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Assets.Font.degularBold, size: 28)
        label.textColor = Assets.Colors.backgroundColorBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Assets.Font.degularBold, size: 28)
        label.textColor = Assets.Colors.backgroundColorBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Assets.Font.degularBold, size: 28)
        label.textColor = Assets.Colors.backgroundColorBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: Assets.Font.degularRegular, size: 18)
        textView.textColor = .systemGray
        textView.isEditable = false
        return textView
    }()
    
    
    var imageUrl: URL
    var doc: Doc
    
    init(imageUrl: URL, doc: Doc) {
        self.imageUrl = imageUrl
        self.doc = doc
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupView()
    }
    
    func setupView() {
        titleLabel.text = doc.title
        headerImageView.load(url: imageUrl)
    }
}

extension BookDetailViewController {
    func setupUI() {
        setupImageViewConstraits()
        setupTitleView()
    }
    
    func setupImageViewConstraits() {
        view.addSubview(headerImageView)
        headerImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 8, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: nil, height: 200, enableInsets: false)
    }
    
    func setupTitleView() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.anchor(top: headerImageView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 8, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: nil, height: nil, enableInsets: false)
    }
}
