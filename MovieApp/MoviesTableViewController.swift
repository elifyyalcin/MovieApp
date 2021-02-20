//
//  MoviesTableViewController.swift
//  MovieApp
//
//  Created by Elif Yalçın on 20.02.2021.
//

import UIKit
import Alamofire

class MoviesTableViewController: UITableViewController {

    var Popular: [Result]? = []
    var Revenue: [Result]? = []
    var TopRated: [Result]? = []

    var movies: [[Result]?]? //array icinde array olacak
    
    let headers = ["Popular","Top Rated","Revenue"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Popular_Connection()
        TopRated_Connection()
        Revenue_Connection()
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.backgroundColor = .orange
        label.text = headers[section]
        return label
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.configure(with: movies?[indexPath.section])
        return cell
    }
     
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 225.0
        }
        else{
            return 225.0
        }
    }

    func Popular_Connection(){
        let params = [ "api_key" : "4f5eec4665e6f25a93c80fdc6ab53a30","sort_by": "popularity.desc"]
        let url = "https://api.themoviedb.org/3/discover/movie"
        AF.request(url, method: .get, parameters: params).responseJSON { (res) in
            
            if (res.response?.statusCode == 200) {
                let movie_data = try? JSONDecoder().decode(MovieData.self, from: res.data!)
                self.Popular = movie_data?.results
                self.tableView.reloadData()
            }
        }
    }
    
    func TopRated_Connection(){
        let params = [ "api_key" : "4f5eec4665e6f25a93c80fdc6ab53a30","sort_by": "vote_count.desc"]
        let url = "https://api.themoviedb.org/3/discover/movie"
        AF.request(url, method: .get, parameters: params).responseJSON { (res) in
            
            if (res.response?.statusCode == 200) {
                let movie_data = try? JSONDecoder().decode(MovieData.self, from: res.data!)
                self.TopRated = movie_data?.results
                self.tableView.reloadData()
            }
        }
    }
    
    
    func Revenue_Connection(){
        let params = [ "api_key" : "4f5eec4665e6f25a93c80fdc6ab53a30","sort_by": "revenue.desc"]
        let url = "https://api.themoviedb.org/3/discover/movie"
        AF.request(url, method: .get, parameters: params).responseJSON { (res) in
            
            if (res.response?.statusCode == 200) {
                let movie_data = try? JSONDecoder().decode(MovieData.self, from: res.data!)
                self.Revenue = movie_data?.results
                self.movies = [self.Popular, self.TopRated, self.Revenue]
                self.tableView.reloadData()
            }
        }
    }
    

    
    //detay sayfasi icin yazilacak
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("Click : \(indexPath.row)")
        let item = movies![indexPath.row]
        print(item as Any)
        performSegue(withIdentifier: "identifier", sender: item)
    }
    


//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if ( segue.identifier == "detail" ) {
//            let vc = segue.destination as!  DetailViewController
//            //vc.item = sender as! [Result]
//        }
//
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
