//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Farid Ramos on 2/5/18.
//  Copyright © 2018 Farid Ramos. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var messages: [PFObject] = []
    
    @IBAction func sendBtn(_ sender: Any) {
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = messageField.text ?? ""
        chatMessage["user"] = PFUser.current()
        
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
            
        }
        
    }
    
    func getMessages() {
        let query = PFQuery(className: "Message")
        query.includeKey("user")
        query.addDescendingOrder("createdAt")
        
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                if let objects = objects {
                    for obj in objects {
                        if obj != nil {
                            //print(obj["text"] )
                        }
                    }
                }
                
                self.messages = objects!
                self.tableView.reloadData()
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 30
        tableView.dataSource = self
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer: Timer) in
            self.getMessages()
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
       
        let message = messages[indexPath.row]
        if let textMessage = message["text"] as?  String {
            cell.txtMessage.text = textMessage
        }
        
        if let user = message["user"] as? PFUser {
            // User found! update username label with username
            cell.username.text = user.username
        } else {
            // No user found, set default username
            cell.username.text = "🤖"
        }
        
        return cell
    }

}
