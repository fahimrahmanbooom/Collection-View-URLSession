//
//  ViewController.swift
//  Collection View AF
//
//  Created by Fahim Rahman on 15/12/19.
//  Copyright © 2019 Fahim Rahman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var heroes = [Hero]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        getNamesFromServer()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.nameLabel.text = heroes[indexPath.row].localized_name?.capitalized
        
        let imageURL = "https://api.opendota.com\(heroes[indexPath.row].img ?? "")"
        
        ImageService.getImage(url: URL(string: imageURL)!) { image in
            
            //DispatchQueue.main.async {
                cell.profileImage.image = image
            //}
        }
        
        cell.profileImage.clipsToBounds = true
        cell.profileImage.layer.cornerRadius = cell.profileImage.frame.height / 2
        cell.profileImage.contentMode = .scaleAspectFill
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        vc.name = heroes[indexPath.row].localized_name ?? "Not Found"
        vc.baseHealth = heroes[indexPath.row].base_health ?? 0
        vc.primaryAttacker = heroes[indexPath.row].primary_attr ?? "Not Found"
        vc.attackType = heroes[indexPath.row].attack_type ?? "Not Found"
        vc.attackRange = heroes[indexPath.row].attack_range ?? 0
        vc.attackRate = heroes[indexPath.row].attack_rate ?? 0
        vc.moveSpeed = heroes[indexPath.row].move_speed ?? 0
        vc.legs = heroes[indexPath.row].legs ?? 0
        vc.roles = heroes[indexPath.row].roles ?? ["Not Found"]
        vc.image = heroes[indexPath.row].img ?? ""
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func getNamesFromServer() {
        
        let url = URL(string: "https://api.opendota.com/api/heroStats")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do {
                    self.heroes = try JSONDecoder().decode([Hero].self, from: data!)
                }
                catch {
                    print("error")
                }
                DispatchQueue.main.sync {
                    self.collectionView.reloadData()
                }
            }
        } .resume()
    }
}
