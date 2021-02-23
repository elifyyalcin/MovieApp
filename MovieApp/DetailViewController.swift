//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Elif Yalçın on 20.02.2021.
//

import UIKit

class DetailViewController: UIViewController {
    public var item:Result?
    
    @IBOutlet weak var MovieInf: UITextView!
    @IBOutlet weak var MovieImg: UIImageView!
    @IBOutlet weak var MovieTitle: UILabel!
    @IBOutlet weak var ReleaseDate: UILabel!
    @IBOutlet weak var VoteAvg: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let OrgPath = "https://image.tmdb.org/t/p/original\(item?.posterPath ?? "")"
        let url = URL(string: OrgPath)
        let data = try! Data(contentsOf: url!)
        MovieImg.image = UIImage(data: data)
        MovieTitle.text = item?.originalTitle
        MovieInf.text = item?.overview
        //ReleaseDate.text = item?.releaseDate
        VoteAvg.text = String(item!.voteAverage)
        
        // dd/mm/yyyy formatinda yazmak icin
        let DateString : String = item!.releaseDate
        let DateCharacters = Array(DateString)
        ReleaseDate.text = "\(DateCharacters[8])" + "\(DateCharacters[9])"+"/"+"\(DateCharacters[5])"+"\(DateCharacters[6])" + "/" + "\(DateCharacters[0])" + "\(DateCharacters[1])" + "\(DateCharacters[2])" + "\(DateCharacters[3])"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

