//
//  API.swift
//  MoviesDBAPP
//
//  Created by yasmeen on 10/25/19.
//  Copyright © 2019 yasmeen. All rights reserved.
//

import Foundation
import Alamofire
class Api: NSObject {
   // https://api.themoviedb.org/3/movie/top_rated?api_key=e64bfbcc0b2b336e875493e881b4ab9b&page=1

    
    static func getMovies(page:Int = 1,endpoint: String, completion: @escaping (_ error :Error?, _ success :Bool?,_ result:[Movie],_ lastPage:Int) -> Void){
        let apiKey = "e64bfbcc0b2b336e875493e881b4ab9b"
        let baseAPIURL = "https://api.themoviedb.org/3"
        
        let url = "\(baseAPIURL)/movie/\(endpoint)?api_key=\(apiKey)&page=\(page)"
        Alamofire.request(url)
            .validate(statusCode: 200..<300)
            .responseJSON{ (response) in
                switch response.result{
                        case .failure( let error):
                            print(error)
                            completion(error,false,[] ,page)
                case .success( let _):
                            let json = response.data
                            do{
                                //created the json decoder
                                let decoder = JSONDecoder()
                                
                                //using the array to put values
                                let moviesResponse = try decoder.decode(MoviesResponse.self, from: json!)
                                let Movies = moviesResponse.results
                                completion(nil,true,Movies ,moviesResponse.total_pages )

                                
                            }catch let err{
                                print(err)
                                completion(nil,false,[],page)
                            }
        
                }

            }
       
    }
    static func getVideos(movieId: Int, completion: @escaping (_ error :Error?, _ success :Bool?,_ result:MovieVideoResponse) -> Void){
        let apiKey = "e64bfbcc0b2b336e875493e881b4ab9b"
        let baseAPIURL = "https://api.themoviedb.org/3"
        let url = "\(baseAPIURL)/movie/\(movieId)/videos?api_key=\(apiKey)"
        Alamofire.request(url)
            .validate(statusCode: 200..<300)
            .responseJSON{ (response) in
                switch response.result{
                case .failure( let error):
                    print(error)
                    completion(error,false,MovieVideoResponse(results: []))
                case .success( let _):
                    let json = response.data
                    do{
                        //created the json decoder
                        let decoder = JSONDecoder()
                        
                        //using the array to put values
                        let videosResponse = try decoder.decode(MovieVideoResponse.self, from: json!)
                        completion(nil,true,videosResponse)
                        
                        
                    }catch let err{
                        print(err)
                        completion(nil,false,MovieVideoResponse(results: []))
                    }
                    
                }
        }
    }
    
    
    static func getreviews(movieId: Int, completion: @escaping (_ error :Error?, _ success :Bool?,_ result:[MovieReview]) -> Void){
        let apiKey = "e64bfbcc0b2b336e875493e881b4ab9b"
        let baseAPIURL = "https://api.themoviedb.org/3"
        let url = "\(baseAPIURL)/movie/\(movieId)/reviews?api_key=\(apiKey)"
        Alamofire.request(url)
            .validate(statusCode: 200..<300)
            .responseJSON{ (response) in
                switch response.result{
                case .failure( let error):
                    print(error)
                    completion(error, false, [])
                    
                case .success( let _):
                    let json = response.data
                    do{
                        //created the json decoder
                        let decoder = JSONDecoder()
                        
                        //using the array to put values
                        let reviews = try decoder.decode(reviewsResponse.self, from: json!)
                        completion(nil,true,reviews.results)
                        
                        
                    }catch let err{
                        print(err)
                        completion(nil,false, [])
                    }
                    
                }
        }
    }
}
