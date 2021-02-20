//
//  CollectionViewCell.swift
//  MovieApp
//
//  Created by Elif Yalçın on 20.02.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var MovieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    

    public func configure(with movie: Result){
        
        self.movieTitle.text = movie.originalTitle
        
        if let ImgPath = movie.posterPath {
            let OrgPath = "https://image.tmdb.org/t/p/original\(ImgPath)"
            let url = URL(string: OrgPath)
            let data = try! Data(contentsOf: url!)
            self.MovieImage.image = UIImage(data: data)
        }

      
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
}
