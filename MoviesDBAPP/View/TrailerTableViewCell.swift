//
//  TrailerTableViewCell.swift
//  MoviesDBAPP
//
//  Created by yasmeen on 10/27/19.
//  Copyright © 2019 yasmeen. All rights reserved.
//

import UIKit
import YouTubePlayer_Swift
class TrailerTableViewCell: UITableViewCell {

   
    @IBOutlet weak var videoview: YouTubePlayerView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configration(movieVideo: MovieVideo)   {
        self.videoview.loadVideoURL(movieVideo.youtubeURL!)
    }

}
