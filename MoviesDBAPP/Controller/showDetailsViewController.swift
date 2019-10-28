//
//  showDetailsViewController.swift
//  MoviesDBAPP
//
//  Created by yasmeen on 10/26/19.
//  Copyright © 2019 yasmeen. All rights reserved.
//

import UIKit

class showDetailsViewController: UIViewController {
    var movie:Movie!
    @IBOutlet weak var moviePackground: UIImageView!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var overView: UITextView!
    @IBOutlet weak var vote: UILabel!
    @IBOutlet weak var releaseDatae: UILabel!
    @IBOutlet weak var MovieTitle: UILabel!
    @IBOutlet weak var profileimageview: UIView!
    @IBOutlet weak var reviewsTable: UITableView!
    
    
    var movieVideos: [MovieVideo]!
    var reviews = [MovieReview](){
        didSet {
            reviewsTable.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewsTable.delegate = self
        reviewsTable.dataSource = self
        
        self.configDetails(movie: self.movie)
        self.moviePoster.layer.cornerRadius = 10
        self.moviePoster.clipsToBounds = true
      
        Api.getreviews(movieId: self.movie.id) { (error: Error?, success : Bool?, result:[MovieReview]) in
            if success! {
                print("success")
                self.reviews = result
                print(self.reviews.count)
                print("success")
                
            }else{
                print("failed")
            }
        }
        
    }


    @IBAction func Action(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Trailers") as! Trailers
        vc.movie = self.movie
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func configDetails(movie:Movie){
        self.overView.text = movie.overview
        self.vote.text = "\(movie.ratingText)(\(movie.vote_average*10)%)"
        self.releaseDatae.text = "\(movie.release_date) (released)"
        self.MovieTitle.text = movie.original_title
        if let url = URL(string:"http://image.tmdb.org/t/p/w185\(movie.poster_path!)"){
            print(url)
            do{
                let data = try Data(contentsOf: url)
                self.moviePoster.image = UIImage(data: data)
                print(true)
            }catch let error{
                print(error.localizedDescription)
            }
        }
        
        
        if let url = URL(string:"http://image.tmdb.org/t/p/w185\(movie.backdrop_path!)"){
            print(url)
            do{
                let data = try Data(contentsOf: url)
                self.moviePackground.image = UIImage(data: data)
                print(true)
            }catch let error{
                print(error.localizedDescription)
            }
        }
    }
    


}
extension showDetailsViewController:UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 209
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reviewsTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! reviewTableViewCell
        cell.configration(review: self.reviews[indexPath.row])
        return cell
    }
    
    
}
