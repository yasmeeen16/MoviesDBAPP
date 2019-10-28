//
//  showallMoviesCollectionViewCell.swift
//  MoviesDBAPP
//
//  Created by yasmeen on 10/26/19.
//  Copyright © 2019 yasmeen. All rights reserved.
//

import UIKit

class showallMoviesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var MoviePoster: UIImageView!
    func configrationCell(movie: Movie) {
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1.0
        
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect:bounds, cornerRadius:contentView.layer.cornerRadius).cgPath
        
        if let url = URL(string:"http://image.tmdb.org/t/p/w185\(movie.poster_path!)"){
            print(url)
            do{
                let data = try Data(contentsOf: url)
                self.MoviePoster.image = UIImage(data: data)
                print(true)
            }catch let error{
                print(error.localizedDescription)
            }
        }
    }
}
