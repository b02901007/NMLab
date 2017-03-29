//
//  Copyright (c) 2015 Google Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Photos
import UIKit

import Firebase
import GoogleMobileAds

/**
 * AdMob ad unit IDs are not currently stored inside the google-services.plist file. Developers
 * using AdMob can store them as custom values in another plist, or simply use constants. Note that
 * these ad units are configured to return only test ads, and should not be used outside this sample.
 */
let kBannerAdUnitID = "ca-app-pub-3940256099942544/2934735716"

@objc(FCViewController)
class FCViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,
    UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,
        FIRInviteDelegate {

  // Instance variables
  
  var ref: FIRDatabaseReference!
  var messages: [FIRDataSnapshot]! = []
  var msglength: NSNumber = 10
  fileprivate var _refHandle: FIRDatabaseHandle!
  let user = FIRAuth.auth()?.currentUser
  var uid: String = ""

  var storageRef: FIRStorageReference!
  var remoteConfig: FIRRemoteConfig!
  var rect: CGRect!
    
  
  @IBOutlet weak var clientTable: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()

    let nib = UINib(nibName: "MyCellTableViewCell", bundle: nil)
    let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
    rect = view.frame
    self.clientTable.register(nib, forCellReuseIdentifier: "tableviewCell")

    configureDatabase()
    let mdata: [String: String] = ["imageUrl" : "",
                                   "name" :(user?.displayName)!,
                                   "photoUrl" : (user?.photoURL?.absoluteString)!,
                                   "text" : "Online",
                                   "uid" : ""
                                  ]
    self.ref.child("users").child((user?.uid)!).setValue(mdata)
  }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rect.size.height
    }
    
    
    deinit {
        if (_refHandle) != nil {
            self.ref.child("users").removeObserver(withHandle: _refHandle)
        }
    }

    func configureDatabase() {
        ref = FIRDatabase.database().reference()
        // Listen for new messages in the Firebase database
        _refHandle = self.ref.child("users").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
            guard let strongSelf = self else { return }
            strongSelf.messages.append(snapshot)
            strongSelf.clientTable.insertRows(at: [IndexPath(row: strongSelf.messages.count-1, section: 0)], with: .automatic)
        })
    }


  // UITableViewDataSource protocol methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messages.count
  }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue cell
        let cell = self.clientTable.dequeueReusableCell(withIdentifier: "tableviewCell", for: indexPath) as! MyCellTableViewCell
        // Unpack message from Firebase DataSnapshot
        let messageSnapshot = self.messages[indexPath.row]
        print("key: " +  (messageSnapshot.key))
        guard let message = messageSnapshot.value as? [String: String] else { return cell }
        let name = message[Constants.MessageFields.name] ?? ""
        let text = message[Constants.MessageFields.text] ?? ""
        cell.label1.text = name
        cell.label2.text = text
        cell.image1.image = UIImage(named: "ic_account_circle")
        if let photoURL = message[Constants.MessageFields.photoURL], let URL = URL(string: photoURL),
            let data = try? Data(contentsOf: URL) {
            cell.image1.image = UIImage(data: data)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "FPVtoM", sender: indexPath);
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FPVtoM"{
            let vc = segue.destination as! MessegeViewController
            let row = (sender as! NSIndexPath).row
            let messageSnapshot = self.messages[row]
            guard let message = messageSnapshot.value as? [String: String] else {return}
            vc.UID = messageSnapshot.key
            vc.names = message["name"] ?? ""
        }
            
    }
  // UITextViewDelegate protocol methods


  // MARK: - Image Picker

  
  @IBAction func signOut(_ sender: UIButton) {
    let firebaseAuth = FIRAuth.auth()
    do {
        try firebaseAuth?.signOut()
        dismiss(animated: true, completion: nil)
    } catch let signOutError as NSError {
        print ("Error signing out: \(signOutError.localizedDescription)")
    }
  }

  func showAlert(withTitle title: String, message: String) {
    DispatchQueue.main.async {
        let alert = UIAlertController(title: title,
            message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .destructive, handler: nil)
        alert.addAction(dismissAction)
        self.present(alert, animated: true, completion: nil)
    }
  }
    
    @IBAction func unwind(for segue: UIStoryboardSegue){
        if segue.identifier == "back_to_FCView"{
            _ = segue.source as! MessegeViewController
        }
    }

}
