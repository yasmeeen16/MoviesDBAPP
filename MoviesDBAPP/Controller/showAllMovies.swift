//
//  showAllMovies.swift
//  MoviesDBAPP
//
//  Created by yasmeen on 10/26/19.
//  Copyright © 2019 yasmeen. All rights reserved.
//

import UIKit

class showAllMovies: UIViewController {
    @IBOutlet weak var MoviesCollection: UICollectionView!
    var categoryName = ""
    var movies = [Movie]() {
        didSet {
            MoviesCollection.reloadData()
        }
    }
    var current_Page = 1
    var last_page = 1
    var isLoading: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        MoviesCollection.delegate = self
        MoviesCollection.dataSource = self
        let layout = self.MoviesCollection.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 9, left:18, bottom: 0, right: 18)
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (self.MoviesCollection.frame.size.width-10)/2, height: (self.MoviesCollection.frame.size.height/3)+10)
        
        getData()

    }
    func getData()  {
        guard !isLoading else {return}
        isLoading = true
        Api.getMovies(endpoint: self.categoryName) { (error : Error?, success : Bool? ,results:[Movie], lastPage:Int) in
            self.isLoading = false
            if success! {
                print("success")
                self.movies = results
                self.current_Page = 1
                self.last_page = lastPage
            }else{
                print("failed")
            }
        }
    }
    
    fileprivate func loadmore(){
        guard !isLoading else {return}
        guard current_Page<last_page else {return}
        self.isLoading = true
        Api.getMovies(page : self.current_Page+1 ,endpoint: self.categoryName) { (error : Error?, success : Bool? ,results:[Movie], lastPage: Int) in
            self.isLoading = false
            if success! {
                print("success")
                self.movies.append(contentsOf: results)
                //self.movies = results
                self.current_Page += 1
                self.last_page = lastPage
            }else{
                print("failed")
            }
        }
    }
   


}
extension showAllMovies:UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MoviesCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! showallMoviesCollectionViewCell
        cell.configrationCell(movie: self.movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "showDetailsViewController") as! showDetailsViewController
        //vc.categoryName = "top_rated"
        vc.movie = self.movies[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let count = self.movies.count
        if indexPath.item == count-1{
            self.loadmore()
        }
    }
}
