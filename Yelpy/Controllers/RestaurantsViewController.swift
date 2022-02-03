//
//  ViewController.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class RestaurantsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // ––––– TODO: Add storyboard Items (i.e. tableView + Cell + configurations for Cell + cell outlets)
    // ––––– TODO: Next, place TableView outlet here
    @IBOutlet weak var tableView: UITableView!
    
    // –––––– TODO: Initialize restaurantsArray
    var restaurantsArray: [[String: Any?]] = []
    
    
    // ––––– TODO: Add tableView datasource + delegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getAPIData()
    }
    
    
    // ––––– TODO: Get data from API helper and retrieve restaurants
    func getAPIData() {
        API.getRestaurants() { (restaurants) in
            guard let restaurants = restaurants else {
                return
            }
            self.restaurantsArray = restaurants
            self.tableView.reloadData()
        }
    }
    
    func restaurantRating(rating: NSNumber) -> String {
        switch rating {
        case 1:
            return "1"
        case 1.5:
            return "1.5"
        case 2:
            return "2"
        case 2.5:
            return "2.5"
        case 3:
            return "3"
        case 3.5:
            return "3.5"
        case 4:
            return "4"
        case 4.5:
            return "4.5"
        case 5:
            return "5"
        default:
            return ""
        }
    }

    // ––––– TODO: Create tableView Extension and TableView Functionality

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Create Restaurant Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        
        let restaurant = restaurantsArray[indexPath.row]
        
        // Set Label to restaurant name for each cell
        cell.restaurantLabel.text = restaurant["name"] as? String ?? ""
        
        // Set Label to restaurant type for each cell
        let categories = restaurant["categories"] as? [[String: Any?]]
        let categoriesTitle = categories?.map({ (category) -> String in
            return (category["title"] as? String ?? "")
        })
        cell.typeLabel.text = categoriesTitle?.joined(separator: ", ")
        
        // Set Label to restaurant review count for each cell
        cell.ratingLabel.text = (restaurant["review_count"] as? NSNumber)?.stringValue
        
        // Set Label to restaurant phone number for each cell
        cell.numLabel.text = restaurant["display_phone"] as? String
        
        // Set Image of restaurant
        if let imageUrlString = restaurant["image_url"] as? String {
            let imageUrl = URL(string: imageUrlString)
            cell.restaurantImage.af.setImage(withURL: imageUrl!)
        }
        
        // Set Image of rating
        cell.ratingView.image = UIImage(named: "regular_" + restaurantRating(rating: restaurant["rating"] as! NSNumber))
        
        
        return cell
    }
}
