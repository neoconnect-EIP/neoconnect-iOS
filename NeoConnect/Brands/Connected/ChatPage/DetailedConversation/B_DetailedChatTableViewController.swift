//
//  B_DetailedChatViewController.swift
//  NeoConnect
//
//  Created by EIP on 03/09/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

import UIKit
import MessageKit
import InputBarAccessoryView

struct sender: SenderType {
    var senderId: String
    var displayName: String
}

struct Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}


class B_DetailedChatViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate, InputBarAccessoryViewDelegate {

    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named:"ShopBackground.png")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let currentUser = sender(senderId: "self", displayName: "")
    let otherUser = sender(senderId: "other", displayName: "")
    var messages = [MessageType]()
    var inf: Inf!
    var isIncoming = true
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        //When use press send button this method is called.
        let newMessage = Message(sender: self.currentUser, messageId: "1", sentDate: Date(), kind: .text(text))
        //calling function to insert and save message
        //clearing input field
        APIManager.sharedInstance.postMessage(id: String(inf.user_id), message: text, onSuccess: {
            print("A message has been sent successfully!")
            self.messages.append(newMessage)
            inputBar.inputTextView.text = ""
            self.messagesCollectionView.reloadData()
            self.messagesCollectionView.scrollToBottom(animated: true)
            self.messageInputBar.inputTextView.resignFirstResponder()
        })
    }
    
    func currentSender() -> SenderType {
        return currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let backBarBtnItem = UIBarButtonItem()
        backBarBtnItem.title = "Retour - \(inf.pseudo)"
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.backItem?.backBarButtonItem = backBarBtnItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        messagesCollectionView.backgroundView = imageView
        getDataFromAPI()
    }
    
    func getDataFromAPI() {
        var data: Array<NSDictionary> = []

        APIManager.sharedInstance.getMessages(id: inf.id, onSuccess: { response in
            let data = response["data"] as! Array<NSDictionary>
            self.messages = self.createArray(data: data)
            self.messagesCollectionView.reloadData()
            self.messagesCollectionView.scrollToBottom(animated: true)
        })
    }
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? UIColor(red: 68/255, green: 81/255, blue: 115/255, alpha: 1.0) : UIColor.white
    }
    
    func createArray(data: Array<NSDictionary>) -> [MessageType] {
        var tempTextMessages = [MessageType]()
                
        for each in data {
            print("EACH")
            let userId = each["userId"] as! Int
            let pseudo = each["pseudo"] as! String
            let message = each["message"] as! String
            let date = each["date"] as! String
            let myId = UserDefaults.standard.integer(forKey: "id")
            tempTextMessages.append(Message(sender: myId != userId ? self.otherUser : self.currentUser,
                                                messageId: String(userId),
                                                sentDate: Date(),
                                                kind: .text(message)))
        }
        return tempTextMessages
    }
}

