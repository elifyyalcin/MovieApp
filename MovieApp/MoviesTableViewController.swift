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

    var movies: [[Result]?]? //array icinde array olacak, ilk once section sonrasında section icerigi gonderilecek.
    
    let headers = ["Popular","Top Rated","Revenue"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Popular_Connection(with: 1){
            self.tableView.reloadData()
        }
        TopRated_Connection(with: 1){
            self.tableView.reloadData()
        }
        Revenue_Connection(with: 1){
            self.tableView.reloadData()
        }
        
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.text = headers[section]
        return label
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.navigateToVC = self
        cell.configure(with: movies?[indexPath.section], section: indexPath.section) //section gonderildi
        return cell
    }


    func Popular_Connection(with pageNumber: Int, onComplete: @escaping () -> ()){
        let params = [ "api_key" : "4f5eec4665e6f25a93c80fdc6ab53a30","sort_by": "popularity.desc", "page":"\(pageNumber)"]
        let url = "https://api.themoviedb.org/3/discover/movie"
        AF.request(url, method: .get, parameters: params).responseJSON { (res) in
            
            if (res.response?.statusCode == 200) {
                let movie_data = try? JSONDecoder().decode(MovieData.self, from: res.data!)
                self.Popular = movie_data?.results
                
                onComplete()
            }
        }
    }
    
    func TopRated_Connection(with pageNumber: Int, onComplete: @escaping () -> ()){
        let params = [ "api_key" : "4f5eec4665e6f25a93c80fdc6ab53a30","sort_by": "vote_count.desc", "page":"\(pageNumber)"]
        let url = "https://api.themoviedb.org/3/discover/movie"
        AF.request(url, method: .get, parameters: params).responseJSON { (res) in
            
            if (res.response?.statusCode == 200) {
                let movie_data = try? JSONDecoder().decode(MovieData.self, from: res.data!)
                self.TopRated = movie_data?.results

                onComplete()
            }
        }
    }
    
    
    func Revenue_Connection(with pageNumber: Int, onComplete: @escaping () -> ()){
        let params = [ "api_key" : "4f5eec4665e6f25a93c80fdc6ab53a30","sort_by": "revenue.desc", "page":"\(pageNumber)"]
        let url = "https://api.themoviedb.org/3/discover/movie"
        AF.request(url, method: .get, parameters: params).responseJSON { (res) in
            
            if (res.response?.statusCode == 200) {
                let movie_data = try? JSONDecoder().decode(MovieData.self, from: res.data!)
                self.Revenue = movie_data?.results
                
                self.movies = [self.Popular, self.TopRated, self.Revenue]

                onComplete()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if ( segue.identifier == "identifier" ) {
            let vc = segue.destination as!  DetailViewController
            vc.item = sender as? Result
        }

    }
    

    

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
