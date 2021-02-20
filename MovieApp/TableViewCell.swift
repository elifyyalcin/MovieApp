//
//  TableViewCell.swift
//  MovieApp
//
//  Created by Elif Yalçın on 20.02.2021.
//

import UIKit
import Alamofire

class TableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var CollectionView: UICollectionView!
    
    public var navigateToVC: UIViewController?
    
    var movies: [Result]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        CollectionView.delegate = self
        CollectionView.dataSource = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with movies: [Result]?){
        self.movies = movies
        CollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 125, height: 250)
    }
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CollectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! CollectionViewCell
        let result = (movies?[indexPath.row])!
        cell.configure(with: result)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("Click : \(indexPath.row)")
        let item = movies![indexPath.row]
        print(item as Any)
        navigateToVC?.performSegue(withIdentifier: "identifier", sender: item)
    }
    
    var isLoading = false
    
    func loadMoreData() {
            if !self.isLoading {
                self.isLoading = true
                DispatchQueue.global().async {
                    // Fake background loading task for 2 seconds
                    sleep(2)
                    // Download more data here
                    DispatchQueue.main.async {
                        self.CollectionView.reloadData()
                        self.isLoading = false
                    }
                }
            }
        }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetX = scrollView.contentOffset.x
            let contentWidth = scrollView.contentSize.width
        

        if (offsetX > contentWidth - scrollView.frame.width * 4) && !isLoading {
                loadMoreData()
            }
        }



}
