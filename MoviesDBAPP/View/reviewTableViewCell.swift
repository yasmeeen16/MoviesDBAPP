//
//  reviewTableViewCell.swift
//  MoviesDBAPP
//
//  Created by yasmeen on 10/27/19.
//  Copyright © 2019 yasmeen. All rights reserved.
//

import UIKit

class reviewTableViewCell: UITableViewCell {

    @IBOutlet weak var author: UILabel!
    
    @IBOutlet weak var reviewcontent: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configration(review: MovieReview) {
        self.author.text = review.author
        self.reviewcontent.text = review.content
    }

}
