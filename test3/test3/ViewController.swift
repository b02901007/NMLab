//
//  ViewController.swift
//  test3
//
//  Created by 呂明峻 on 2017/2/27.
//  Copyright © 2017年 呂明峻. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate{

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var home: UIButton!
    @IBOutlet weak var foot: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var list1 = [[String]]()
    var filtered = [[String]]()
    var rect: CGRect!
    var shouldShowSearchResults = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        list1.append(["KTV","Sing songs with your friends!","DSC_0063.jpg"])
        list1.append(["Night Market","Traditional market with lots of food","y1w2e7f8j5j502d9p174.jpg"])
        list1.append(["Shopping","Shop your favorite brand in the department store!","912181048321124.jpg"])
        list1.append(["Surfing","Fight with the waves!","Surfer-Riding-A-Wave-ipad-wallpaper-ilikewallpaper_com.jpg"])
        list1.append(["Hiking","Conquer the dangerous!","hiking-guide-copy-2.jpg"])
        
        
        
        let nib = UINib(nibName: "MyCellTableViewCell", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        rect = view.frame
        tableView.register(nib, forCellReuseIdentifier: "Cell")
        
        home.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
        home.setImage(UIImage(named: "black-white-home-icon_338292.png"), for: UIControlState.normal)

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if shouldShowSearchResults {
            return filtered.count
        }
        else {
            return list1.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyCellTableViewCell
        cell.image1.contentMode = .scaleToFill
        cell.image2.contentMode = .scaleToFill
        
        cell.image2.image = UIImage(named: "Enclosure icon.png")
        
        if shouldShowSearchResults{
            cell.label1.text = filtered[indexPath.row][0]
            cell.label2.text = filtered[indexPath.row][1]
            cell.image1.image = UIImage(named: filtered[indexPath.row][2])
        }
        else{
            cell.label1.text = list1[indexPath.row][0]
            cell.label2.text = list1[indexPath.row][1]
            cell.image1.image = UIImage(named: list1[indexPath.row][2])
        }
        // Configure the cell...
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rect.size.height
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tableView.reloadData()
        }
        print("cool")
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("HI")
        guard let searchString = searchBar.text else {
            return
        }
        
        // Filter the data array and get only those countries that match the search text.
        filtered = list1.filter({ (country) -> Bool in
            let countryText:String = country[0]
            print(country[0])
            return (countryText.lowercased().range(of: searchString.lowercased())) != nil})
        
        
        // Reload the tableview.
        if searchText != ""{
            shouldShowSearchResults = true
            tableView.reloadData()
        }
        else{
            shouldShowSearchResults = false
            tableView.reloadData()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.searchBar.resignFirstResponder()
        super.touchesBegan(touches, with:event)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         self.performSegue(withIdentifier: "next", sender: indexPath);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "next") {
            let vc = segue.destination as! TableViewController
            let row = (sender as! NSIndexPath).row; //we know that sender is an NSIndexPath here.
            if shouldShowSearchResults{
                switch  filtered[row][0]{
                case "KTV":
                    vc.status = "KTV"
                case "Night Market":
                    vc.status = "Night Market"
                case "Shopping":
                    vc.status = "Shopping"
                case "Surfing":
                    vc.status = "Surfing"
                case "Hiking":
                    vc.status = "Hiking"
                default:
                    break
                }
            }
            else{
                switch  list1[row][0]{
                case "KTV":
                    vc.status = "KTV"
                case "Night Market":
                    vc.status = "Night Market"
                case "Shopping":
                    vc.status = "Shopping"
                case "Surfing":
                    vc.status = "Surfing"
                case "Hiking":
                    vc.status = "Hiking"
                default:
                    break
                }

            }
        }
    }
}

