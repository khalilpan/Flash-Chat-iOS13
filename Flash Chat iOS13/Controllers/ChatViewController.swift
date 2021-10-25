//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Khalil Panahi
//

import Firebase
import UIKit

class ChatViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var messageTextfield: UITextField!

    let db = Firestore.firestore()

    var messages: [Message] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        title = K.title
        // to hide back button from navigation bar in the chat view controller
        navigationItem.hidesBackButton = true

        tableView.register(UINib(nibName: K.CellNibName, bundle: nil), forCellReuseIdentifier: K.reusableCell)

        loadMessages()
    }

    func loadMessages() {
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { querySnapshot, err in

                self.messages = []

                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    if let snapShotDocuments = querySnapshot?.documents {
                        for document in snapShotDocuments {
                            print("\(document.documentID) => \(document.data())")
                            let data = document.data()
                            if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                                let newMessage = Message(sender: messageSender, body: messageBody)
                                self.messages.append(newMessage)

                                DispatchQueue.main.async {
                                    // reload tableView's data
                                    self.tableView.reloadData()
                                    let inexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                    self.tableView.scrollToRow(at: inexPath, at: .top, animated: true)
                                }
                            }
                        }
                    }
                }
            }
    }

    @IBAction func sendPressed(_: UIButton) {
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            // Add a new document with a generated ID
            var ref: DocumentReference?
            ref = db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messageSender,
                K.FStore.bodyField: messageBody,
                K.FStore.dateField: Date().timeIntervalSince1970,
            ]) { err in
                if let er = err {
                    print("Error adding document: \(er)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                    
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                    
                }
            }
        }
    }

    @IBAction func logOut(_: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()

            // to take the user back onto root page(welcome view controller)
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

//MARK: - UITableViewDataSource

extension ChatViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.reusableCell, for: indexPath) as! MessageCell
        cell.label.text = message.body
        
        //this is a message from logged user
        if message.sender == Auth.auth().currentUser?.email{
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: K.BrandColors.purple)
        }
        //this is a message from another sender
        else{
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.label.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        
        

//        cell.label.text = messages[indexPath.row].body
        

        return cell
    }
}
