//
//  MessegeViewController.swift
//  FriendlyChatSwift
//
//  Created by 呂明峻 on 2017/3/27.
//  Copyright © 2017年 Google Inc. All rights reserved.
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

@objc(MessegeViewController)
class MessegeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,
    UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,
FIRInviteDelegate {
    
    // Instance variables
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var Name: UILabel!
    var ref: FIRDatabaseReference!
    var messages: [FIRDataSnapshot]! = []
    var msglength: NSNumber = 10
    fileprivate var _refHandle: FIRDatabaseHandle!
    let user = FIRAuth.auth()?.currentUser
    var uid: String = ""
    var UID: String = ""
    var names: String = ""
    
    var storageRef: FIRStorageReference!
    var remoteConfig: FIRRemoteConfig!
    var rect: CGRect!
    
    @IBOutlet weak var banner: GADBannerView!
    @IBOutlet weak var clientTable: UITableView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint1: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint2: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "MyCellTableViewCell", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        rect = view.frame
        self.clientTable.register(nib, forCellReuseIdentifier: "viewCell")
        Name.text = names
        clientTable.separatorStyle = .none
        print("UID: " + (self.UID))
        print("uid: " + (user?.uid)!)
        
        configureDatabase()
        configureStorage()
        configureRemoteConfig()
        fetchConfig()
        loadAd()
        logViewLoaded()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        if textField.text == ""{
            sendButton.isEnabled = false
        }
        else{
            sendButton.isEnabled = true
        }
        
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    func keyboardWillShow(notification:Notification){
        adjustingHeight(show: true, notification: notification)
    }
    func keyboardWillHide(notification: Notification){
        adjustingHeight(show: false, notification: notification)
    }
    
    func adjustingHeight(show:Bool, notification:Notification){
        var userInfo = notification.userInfo!
        let keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? CGRect)!
        let animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        let changeInHeight = (keyboardFrame.size.height ) * (show ? 1 : -1)
        UIView.animate(withDuration: animationDuration, animations: {() -> Void in
            self.bottomConstraint.constant += changeInHeight
            self.bottomConstraint1.constant += changeInHeight
            self.bottomConstraint2.constant += changeInHeight
            let heigher = self.clientTable.contentSize.height > self.clientTable.frame.size.height
            let offset = CGPoint(x: 0, y: (show || heigher ? self.clientTable.contentSize.height - self.clientTable.frame.size.height : 0) + (show ? changeInHeight : 0))
            self.clientTable.setContentOffset(offset, animated: false)
        })
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.clientTable.contentSize.height > self.clientTable.frame.size.height{
            let offset = CGPoint(x: 0, y: self.clientTable.contentSize.height - self.clientTable.frame.size.height)
            self.clientTable.setContentOffset(offset, animated: false)
        }
        
        
    }
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rect.size.height
    }
    
    
    deinit {
        if (_refHandle) != nil {
            self.ref.child("messages").child((user?.uid)!).child(UID).removeObserver(withHandle: _refHandle)
        }
    }
    
    func configureDatabase() {
        ref = FIRDatabase.database().reference()
        // Listen for new messages in the Firebase database
        _refHandle = self.ref.child("messages").child((user?.uid)!).child(UID).observe(.childAdded, with: { [weak self] (snapshot) -> Void in
            guard let strongSelf = self else { return }
            print("UID2: " + (self?.UID)!)
            strongSelf.messages.append(snapshot)
            strongSelf.clientTable.insertRows(at: [IndexPath(row: strongSelf.messages.count-1, section: 0)], with: .automatic)
            strongSelf.clientTable.scrollToRow(at: IndexPath(row: strongSelf.messages.count-1, section: 0), at: .bottom, animated: true)
        })
        
    }
    
    func configureStorage() {
    }
    
    func configureRemoteConfig() {
    }
    
    func fetchConfig() {
    }
    
    @IBAction func didPressFreshConfig(_ sender: AnyObject) {
        fetchConfig()
    }
    
    @IBAction func didSendMessage(_ sender: UIButton) {
        _ = textFieldShouldReturn(textField)
    }
    
    @IBAction func didPressCrash(_ sender: AnyObject) {
        fatalError()
    }
    
    @IBAction func inviteTapped(_ sender: AnyObject) {
    }
    
    func logViewLoaded() {
    }
    
    func loadAd() {
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= self.msglength.intValue // Bool
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        if textField.text == "" {
            sendButton.isEnabled = false
        }
        else{
            sendButton.isEnabled = true
        }
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
        let cell = self.clientTable.dequeueReusableCell(withIdentifier: "viewCell", for: indexPath) as! MyCellTableViewCell
        // Unpack message from Firebase DataSnapshot
        let messageSnapshot = self.messages[indexPath.row]
        guard let message = messageSnapshot.value as? [String: String] else { return cell }
        let name = message[Constants.MessageFields.name] ?? ""
        let text = message[Constants.MessageFields.text] ?? ""
        cell.label1.text = text
        cell.label2.text = name
        cell.image1.image = UIImage(named: "ic_account_circle")
        if let photoURL = message[Constants.MessageFields.photoURL], let URL = URL(string: photoURL),
            let data = try? Data(contentsOf: URL) {
            cell.image1.image = UIImage(data: data)
        }
        cell.selectionStyle = .none
        return cell
    }
    // UITextViewDelegate protocol methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return true }
        textField.text = ""
        view.endEditing(true)
        let data = [Constants.MessageFields.text: text]
        sendMessage(withData: data)
        return true
    }
    
    func sendMessage(withData data: [String: String]) {
        let key = self.ref.child("messages").child((user?.uid)!).child(UID).childByAutoId().key
        let post = ["UID": (user?.uid)!,
                    "name": (user?.displayName)!,
                    "imageUrl": "",
                    "photoUrl": (user?.photoURL)!.absoluteString,
                    "text": data["text"]!] as [String : String]
        let childUpdates = ["/messages/\((user?.uid)!)/\(UID)/\(key)": post,
                            "/messages/\(UID)/\((user?.uid)!)/\(key)": post]
        self.ref.updateChildValues(childUpdates)
        
    }
    
    // MARK: - Image Picker
    
    @IBAction func didTapAddPhoto(_ sender: AnyObject) {
        let picker = UIImagePickerController()
        picker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            picker.sourceType = UIImagePickerControllerSourceType.camera
        } else {
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        }
        
        present(picker, animated: true, completion:nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion:nil)
        guard let uid = FIRAuth.auth()?.currentUser?.uid else { return }
        
        // if it's a photo from the library, not an image from the camera
        if #available(iOS 8.0, *), let referenceURL = info[UIImagePickerControllerReferenceURL] as? URL {
            let assets = PHAsset.fetchAssets(withALAssetURLs: [referenceURL], options: nil)
            let asset = assets.firstObject
            asset?.requestContentEditingInput(with: nil, completionHandler: { (contentEditingInput, info) in
                let imageFile = contentEditingInput?.fullSizeImageURL
                let filePath = "\(uid)/\(Int(Date.timeIntervalSinceReferenceDate * 1000))/\((referenceURL as AnyObject).lastPathComponent!)"
            })
        } else {
            guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
            let imageData = UIImageJPEGRepresentation(image, 0.8)
            guard let uid = FIRAuth.auth()?.currentUser?.uid else { return }
            let imagePath = "\(uid)/\(Int(Date.timeIntervalSinceReferenceDate * 1000)).jpg"
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion:nil)
    }
    
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
    
    
    
}
