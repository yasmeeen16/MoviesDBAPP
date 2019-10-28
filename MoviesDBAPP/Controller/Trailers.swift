//
//  Trailers.swift
//  MoviesDBAPP
//
//  Created by yasmeen on 10/27/19.
//  Copyright © 2019 yasmeen. All rights reserved.
//

import UIKit
import YouTubePlayer_Swift
class Trailers: UIViewController {
    var movie:Movie!
    var movieVideos = [MovieVideo](){
        didSet {
            trailersvedios.reloadData()
        }
    }
    @IBOutlet weak var trailersvedios: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        Api.getVideos(movieId: movie.id) { (error : Error?, success : Bool? , results:MovieVideoResponse) in
            if success! {
                self.movieVideos = results.results
                for m in self.movieVideos{
                    print(m.youtubeURL!)
                }
                
            }else{
                print("failed")
            }
        }
    }
}
extension Trailers:UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieVideos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = trailersvedios.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TrailerTableViewCell
        cell.configration(movieVideo: movieVideos[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    
}
