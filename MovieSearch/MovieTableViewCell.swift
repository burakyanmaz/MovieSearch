//
//  MovieTableViewCell.swift
//  MovieSearch
//
//  Created by NDSDEVTEAM9 on 21.09.2018.
//  Copyright © 2018 simpler. All rights reserved.
//

import UIKit
// https://github.com/onevcat/Kingfisher/wiki/Cheat-Sheet
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setMovieCell(with movie: MovieResult) {
        titleLabel.text = movie.title ?? "No title"
        overviewLabel.text = movie.overview ?? "No overview"
        releaseDateLabel.text = "Release date: \(movie.releaseDate ?? "N/A")"
        
        if let theImageURLString = movie.posterPath {
            posterImageView.kf.indicatorType = .activity
            posterImageView.kf.setImage(with: URL.init(string: WebServiceAPI.Poster.poster(with: .w185, posterPath: theImageURLString).url))
        }
    }
    
    func stopLoadingThePoster() {
        posterImageView.kf.cancelDownloadTask()
    }
}
