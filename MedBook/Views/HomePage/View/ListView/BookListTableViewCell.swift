//
//  BookListTableViewCell.swift
//  MedBook
//
//  Created by Gokul on 01/09/23.
//

import UIKit

class BookListTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var bookImageView: UIImageView!
    @IBOutlet var internalContainerView: UIView!
    @IBOutlet var ratingStackView: UIStackView!
    @IBOutlet var imageViewContainer: UIView!
    @IBOutlet var countStackView: UIStackView!
    
    var data: Doc?

    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    func configureView() {
        internalContainerView.layer.cornerRadius = 10
        internalContainerView.clipsToBounds = true
        bookImageView.layer.cornerRadius = 10
        bookImageView.clipsToBounds = true
        imageViewContainer.layer.cornerRadius = 10
        imageViewContainer.clipsToBounds = true
    }
    
    func setupViewWith(data: Doc?) {
        guard let data else { return }
        
        titleLabel.text = data.title ?? "-"
        if let rating = data.ratings_average {
            let roundedRating = round(rating * 10) / 10
            ratingLabel.text = "\(roundedRating)"
            ratingLabel.isHidden = false
        } else {
            ratingStackView.isHidden = true
        }
        if let count = data.ratings_count {
            countLabel.text = "\(count)"
            countLabel.isHidden = false

        } else {
            countStackView.isHidden = true
            countLabel.isHidden = true
        }
        if let authorName = data.author_name?.first {
            self.authorLabel.text = authorName
        }
        guard let coverI = data.cover_i, let url = URL(string: "https://covers.openlibrary.org/b/id/\(coverI)-M.jpg") else { return }
        bookImageView.load(url: url)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        ratingLabel.text = ""
        authorLabel.text = ""
        bookImageView.image = nil
        titleLabel.text = ""
        ratingStackView.isHidden = false
        countStackView.isHidden = false
    }
}
