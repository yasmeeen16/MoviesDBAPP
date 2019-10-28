//
//  ViewController.swift
//  MoviesDBAPP
//
//  Created by yasmeen on 10/25/19.
//  Copyright © 2019 yasmeen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TopRatedCollection: UICollectionView!
    
    @IBOutlet weak var PopularMoviesCollection: UICollectionView!
   
    @IBOutlet weak var CommingSooonCollection: UICollectionView!
    
    @IBOutlet weak var PlayingNowCollection: UICollectionView!
    
    
    @IBOutlet var ShowAll: [UIButton]!
    @IBOutlet weak var TopRatedLabel: UILabel!
    @IBOutlet weak var moviesLabel: UILabel!
    @IBOutlet weak var moviesLabel2: UILabel!
    @IBOutlet weak var popularLabel: UILabel!
    @IBOutlet weak var commingLabel: UILabel!
    @IBOutlet weak var soonLabe: UILabel!
    @IBOutlet weak var playingLabel: UILabel!
    @IBOutlet weak var nowLabel: UILabel!
    
    
    var movies = [Movie]() {
        didSet {
            TopRatedCollection.reloadData()
        }
    }
    var Popularmovies = [Movie]() {
        didSet {
            PopularMoviesCollection.reloadData()
        }
    }
    
    var commingSoonmovies = [Movie]() {
        didSet {
            CommingSooonCollection.reloadData()
        }
    }
    
    var playingNow = [Movie]() {
        didSet {
            PlayingNowCollection.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TopRatedCollection.delegate = self
        TopRatedCollection.dataSource = self
        PopularMoviesCollection.delegate = self
        PopularMoviesCollection.dataSource = self
        CommingSooonCollection.delegate = self
        CommingSooonCollection.dataSource = self
        PlayingNowCollection.dataSource = self
        PlayingNowCollection.delegate = self
        self.title = NSLocalizedString("title_text", comment: "")
        configLocalization()
        Api.getMovies(endpoint: "top_rated") { (error : Error?, success : Bool? ,results:[Movie],lastPage:Int) in
                        if success! {
                            print("success")
                            self.movies = results
                        }else{
                            print("failed")
                        }
        }
        
        Api.getMovies(endpoint: "popular") { (error : Error?, success : Bool? ,results:[Movie] ,lastPage:Int) in
            if success! {
                print("success")
                self.Popularmovies = results
            }else{
                print("failed")
            }
        }
        
        Api.getMovies(endpoint: "upcoming") { (error : Error?, success : Bool? ,results:[Movie] ,lastPage:Int) in
            if success! {
                print("success")
                self.commingSoonmovies = results
            }else{
                print("failed")
            }
        }
        
        Api.getMovies(endpoint: "now_playing") { (error : Error?, success : Bool? ,results:[Movie], lastPage:Int) in
            if success! {
                print("success")
                self.playingNow = results
            }else{
                print("failed")
            }
        }
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.red]

    }
    
    func configLocalization(){
        for btn in ShowAll{
           btn.setTitle(NSLocalizedString("show_all_btn", comment: ""), for: .normal)
        }
        self.moviesLabel.text = NSLocalizedString("movies", comment: "")
        self.moviesLabel2.text = NSLocalizedString("movies", comment: "")
        self.TopRatedLabel.text = NSLocalizedString("top_rated", comment: "")
        self.popularLabel.text = NSLocalizedString("popular", comment: "")
        self.commingLabel.text = NSLocalizedString("coming", comment: "")
        self.soonLabe.text = NSLocalizedString("soon", comment: "")
        self.nowLabel.text = NSLocalizedString("now", comment: "")
        self.playingLabel.text = NSLocalizedString("playing", comment: "")

    }


    @IBAction func ShowAllTopRated(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "showAllMovies") as! showAllMovies
        vc.categoryName = "top_rated"
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func ShowAllPopular(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "showAllMovies") as! showAllMovies
        vc.categoryName = "popular"
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func ShowAllCommingSoon(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "showAllMovies") as! showAllMovies
        vc.categoryName = "upcoming"
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func ShowAllPlayingNow(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "showAllMovies") as! showAllMovies
        vc.categoryName = "now_playing"
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return self.movies.count
        }
        if collectionView.tag == 2{
            return self.Popularmovies.count
        }
        if collectionView.tag == 3{
            return self.commingSoonmovies.count
        }
        if collectionView.tag == 4{
            return self.playingNow.count
        }else{
            return 0
        }
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        

        if collectionView.tag == 1 {
            let cell = TopRatedCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TopRatedCollectionViewCell
            
            cell.configrationCell(movie: self.movies[indexPath.row])
            return cell
            
        }
        if collectionView.tag == 2 {
            let cell1 = PopularMoviesCollection.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! TopRatedCollectionViewCell
            
            cell1.configrationCell(movie: self.Popularmovies[indexPath.row])
            return cell1
            
        }
        if collectionView.tag == 3 {
            let cell = CommingSooonCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TopRatedCollectionViewCell
            
            cell.configrationCell(movie: self.commingSoonmovies[indexPath.row])
            return cell
            
        }else{
            
            let cell = PlayingNowCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TopRatedCollectionViewCell
            
            cell.configrationCell(movie: self.playingNow[indexPath.row])
            return cell
            
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "showDetailsViewController") as! showDetailsViewController
            //vc.categoryName = "top_rated"
            vc.movie = self.movies[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        
        }else if collectionView.tag == 2 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "showDetailsViewController") as! showDetailsViewController

            vc.movie = self.Popularmovies[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)

        }else if collectionView.tag == 3 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "showDetailsViewController") as! showDetailsViewController
            vc.movie = self.commingSoonmovies[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }else if collectionView.tag == 4 {

            let vc = storyboard?.instantiateViewController(withIdentifier: "showDetailsViewController") as! showDetailsViewController
            vc.movie = self.playingNow[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)

        }
        
    }
    

}

