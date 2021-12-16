//
//  MovieDetailViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/26/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit
import WebKit

class MovieDetailViewController: UIViewController {
    
    var movieModel: MovieModel?
    
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var release_date_label: UILabel?
    @IBOutlet weak var poster_img_view: UIImageView?
    @IBOutlet weak var overview_text_view: UITextView?
    
    override func viewDidLoad() {
        if (movieModel != nil) {
            
            let path = String("https://image.tmdb.org/t/p/original/\(movieModel?.poster_path ?? "")")
            let imageLink = URL(string:path)!
            let release_date_str = movieModel?.release_date
            
            self.titleLabel?.text = movieModel?.title ?? ""
            self.overview_text_view?.text = movieModel?.overview ?? ""
            if release_date_str != nil {
                self.release_date_label?.text = String("Release Date: \(release_date_str!)")
            }
            
            //self.poster_web_view?.load(URLRequest(url: imageLink))
            // Fetch Image Data
            
            /*
            debugPrint(path)
            if let data = try? Data(contentsOf: imageLink) {
                // Create Image and Update Image View
                self.poster_img_view!.image = UIImage(data: data)
            }*/
            
            self.titleLabel?.backgroundColor = .clear
            self.release_date_label?.backgroundColor = .clear
            self.poster_img_view?.backgroundColor = .clear
            self.overview_text_view?.backgroundColor = .clear
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let path = String("https://image.tmdb.org/t/p/original/\(movieModel?.poster_path ?? "")")
        let imageLink = URL(string:path)!
        if let data = try? Data(contentsOf: imageLink) {
            self.poster_img_view!.image = UIImage(data: data)
        }
    }
    
    
    deinit {
        debugPrint("inside MovieDetailViewController deinit")
    }
    
}
