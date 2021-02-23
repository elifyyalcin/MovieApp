//
//  TableViewCell.swift
//  MovieApp
//
//  Created by Elif Yalçın on 20.02.2021.
//

import UIKit
import Alamofire

class TableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var pageNum: Int = 0

    var TVC = MoviesTableViewController()

    @IBOutlet weak var CollectionView: UICollectionView!
    
    public var navigateToVC: UIViewController? //segue kullanımı icin bir VC olusturuldu
    
    var section: Int = 0
    var movies: [Result]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        CollectionView.delegate = self
        CollectionView.dataSource = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //collectionview'un datalar geldikten sonra reload edilmesi
    func configure(with movies: [Result]?, section: Int){
        self.movies = movies
        self.section = section
        CollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 250)
    }
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    
    //dönen result'ın configure ile gonderilmesi ve cell'in yapılandırılması
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CollectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! CollectionViewCell

        let result = (movies?[indexPath.row])!
        cell.configure(with: result)
        return cell
    }
    
    //cell'e tıklanıldığında tıklanılan item'ın performsegue ile viewcontroller'a aktarılması
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("Click : \(indexPath.row)") //control
        let item = movies![indexPath.row]
        print(item as Any) //control
        
        navigateToVC?.performSegue(withIdentifier: "identifier", sender: item)
    }
    
    //section sonuna gelindiginde pagination yapilmasi --page+1--
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        if self.section == 0 {
            if indexPath.row == movies!.count - 1 {
                print(section)
                pageNum = calculatePage(moviesCount: movies!.count)
                print(pageNum)
                self.TVC.Popular_Connection(with: pageNum+1){
                    self.CollectionView.reloadData()
                }
            }
        }
        
        else if self.section == 1 {
            if indexPath.row == movies!.count - 1 {
                print(section)
                pageNum = calculatePage(moviesCount: movies!.count)
                self.TVC.TopRated_Connection(with: pageNum+1){
                    self.CollectionView.reloadData()

                }
            }
        }
        
        else if self.section == 2 {
            if indexPath.row == movies!.count - 1 {
                print(section)
                pageNum = calculatePage(moviesCount: movies!.count)
                self.TVC.Revenue_Connection(with: pageNum+1){
                    self.CollectionView.reloadData()
                }
            }
        }
    }
    
    //api default olarak 20 data donduruyor. kacinci sayfada bulunuldugunun hesaplanmasi
    func calculatePage(moviesCount: Int) -> Int {
        let page = moviesCount / 20
        return page
    }
}

    



