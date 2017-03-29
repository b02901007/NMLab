//
//  TableViewController.swift
//  test3
//
//  Created by 呂明峻 on 2017/2/27.
//  Copyright © 2017年 呂明峻. All rights reserved.
//

import UIKit



class TableViewController: UITableViewController {
    
    var KTV = [[String]]()
    var NightMarket = [[String]]()
    var Shopping = [[String]]()
    var Surfing = [[String]]()
    var Hiking = [[String]]()
    var status: String = ""
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        KTV.append(["好樂迪","Sing songs with your friends!","DSC_0063.jpg"])
        KTV.append(["星聚點","Sing songs with your friends!","DSC_0063.jpg"])
        KTV.append(["好樂迪2","Sing songs with your friends!","DSC_0063.jpg"])
        
        NightMarket.append(["羅東夜市","Traditional market with lots of food","y1w2e7f8j5j502d9p174.jpg"])
        NightMarket.append(["桃園夜市","Traditional market with lots of food","y1w2e7f8j5j502d9p174.jpg"])
        NightMarket.append(["師大夜市","Traditional market with lots of food","y1w2e7f8j5j502d9p174.jpg"])
        
        Shopping.append(["遠東百貨","Shop your favorite brand in the department store!","912181048321124.jpg"])
        Shopping.append(["新光三越","Shop your favorite brand in the department store!","912181048321124.jpg"])
        Shopping.append(["Sogo百貨","Shop your favorite brand in the department store!","912181048321124.jpg"])
        
        let nib = UINib(nibName: "MyCellTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
        
        let swipeGestureRecognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(TableViewController.back))
        swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirection.right
        tableView.addGestureRecognizer(swipeGestureRecognizer)
        swipeGestureRecognizer.delegate = self.tableView as! UIGestureRecognizerDelegate?

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func back(recognizer: UIGestureRecognizer){
        if recognizer.state == UIGestureRecognizerState.ended {
            self.performSegue(withIdentifier: "back_to_vc", sender: self)
            print("Hello")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch status {
        case "KTV":
            return KTV.count
        case "Night Market":
            return NightMarket.count
        case "Shopping":
            return Shopping.count
        default:
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyCellTableViewCell
        cell.image1.contentMode = .scaleToFill
        cell.image2.contentMode = .scaleToFill
        cell.image2.image = UIImage(named: "Enclosure icon.png")
        
        switch status {
        case "KTV":
            cell.image1.image = UIImage(named: KTV[indexPath.row][2])
            cell.label1.text = KTV[indexPath.row][0]
            cell.label2.text = KTV[indexPath.row][1]
        case "Night Market":
            cell.image1.image = UIImage(named: NightMarket[indexPath.row][2])
            cell.label1.text = NightMarket[indexPath.row][0]
            cell.label2.text = NightMarket[indexPath.row][1]
        case "Shopping":
            cell.image1.image = UIImage(named: Shopping[indexPath.row][2])
            cell.label1.text = Shopping[indexPath.row][0]
            cell.label2.text = Shopping[indexPath.row][1]
        default:
            break
        }
        
        
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
