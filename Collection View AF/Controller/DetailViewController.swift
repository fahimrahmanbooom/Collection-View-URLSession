//
//  DetailViewController.swift
//  Collection View AF
//
//  Created by Fahim Rahman on 28/12/19.
//  Copyright © 2019 Fahim Rahman. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var detailTableView: UITableView!
    
    
    var heroes = [Hero]()
    
    var name = String()
    var baseHealth = Int()
    var primaryAttacker = String()
    var attackType = String()
    var attackRange = Int()
    var attackRate = Double()
    var moveSpeed = Int()
    var legs = Int()
    var roles = [String]()
    var image = String()
    
    let detail = ["Name","Base Health","Primary Attacker","Attack Type","Attack Range","Attack Rate","Move Speed","Legs","Roles"]
    
    var heroRoles = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailTableView.delegate = self
        detailTableView.dataSource = self
        
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.contentMode = .scaleAspectFill
        
        getDetails()
        rolesOfHeroes()
        
    }
    // @IBOutlet weak var labellayout: NSLayoutConstraint!
    
    func getDetails() {
        
        ImageService.getImage(url: URL(string: "https://api.opendota.com\(image)")!) { image in
            
            self.imageView.image = image
        }
    }
    
    
    func rolesOfHeroes() {
        
        for i in 0...self.roles.count - 1 {
            
            self.heroRoles += self.roles[i]
            self.heroRoles += ","
        }
        self.heroRoles = String(self.heroRoles.dropLast())
        //print(self.heroRoles)
    }
}


extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return detail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: detailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! detailTableViewCell
        
        
        let detailData = [name,String(baseHealth),primaryAttacker,attackType,String(attackRange),String(attackRate),String(moveSpeed),String(legs),heroRoles] as [Any]
        
        DispatchQueue.main.async {
            
            cell.detailCellLabel.text = self.detail[indexPath.row]
            cell.detailCellData.text = detailData[indexPath.row] as? String

        }
        
        return cell
    }
}
