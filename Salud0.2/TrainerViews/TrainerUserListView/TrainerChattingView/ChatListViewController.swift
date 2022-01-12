//
//  ChatViewController.swift
//  Salud0.2
//
//  Created by 이관형 on 2021/11/08.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase
import SwiftUI
import SnapKit

class ChattingListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let uid = Auth.auth().currentUser?.uid
    var array: [UserChatModel] = []
    var keys: [String] = []
    var destinationUsers: [String] = []
    var chatArray: [ChatModel] = []
    var centercode:String = ""
    
    
    private let noneFieldText: UITextField = {
        let text = UITextField()
        text.isUserInteractionEnabled = false
        return text
    }()
    lazy var tableview:UITableView = {
        let tableview = UITableView()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(ChatListTableViewCell.self, forCellReuseIdentifier: "ChatListTableViewCell")
        tableview.separatorStyle = .none
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        makeLayout()
        getcenterCode()
    }
    
    private func makeLayout(){
        [tableview].forEach{
            view.addSubview($0)
        }
        tableview.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    func getcenterCode(){
        guard let trainercode = Auth.auth().currentUser?.uid else{return}
        Database.database().reference()
            .child("Trainer")
            .child(trainercode)
            .child("fitnessCode")
            .observeSingleEvent(of: .value){snapshot in
                guard let code = snapshot.value as? String else{return}
                self.centercode = code
                self.getUserList(centercode: code)
            }
    }
    
    func getUserList(centercode:String){
        guard let trainercode = Auth.auth().currentUser?.uid else{return}
        Database.database().reference()
            .child("ChatList")
            .child(centercode)
            .child(trainercode)
            .observeSingleEvent(of: .value){snapshot in
                let values = snapshot.value as! [String:[String:Any]]
                for value in values.keys{
                    self.keys.append(value)
                }
                
                for userid in self.keys{
                    Database.database().reference()
                        .child("User")
                        .child(userid)
                        .observeSingleEvent(of: .value){snapshot in
                            let usermodel = UserChatModel()
                            usermodel.setValuesForKeys(snapshot.value as! [String:String])
                            self.array.append(usermodel)
                            self.getChattingRoomList(centercode: centercode, userid: userid)
                        }
                }
            }
    }
    
    func getChattingRoomList(centercode:String,userid:String){
        guard let trainerid = Auth.auth().currentUser?.uid else {return}
        self.chatArray = []
        Database.database().reference()
            .child("Chats")
            .child(centercode)
            .child(trainerid)
            .child(userid)
            .queryLimited(toLast: 1)
            .observeSingleEvent(of: .value){snapshot in
//                print(snapshot)
                for childsnap in snapshot.children{
                    let childsnap = childsnap as! DataSnapshot
                    let chatmodel = ChatModel()
                    chatmodel.setValuesForKeys(childsnap.value as! [String:String])
                    self.chatArray.append(chatmodel)
                }
            }
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }

    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        print("selected \(indexPath)")
        let userid = array[indexPath.row].uid
        guard let userid = userid else{return}
        let viewcontroller = ChattingRoomViewController(userid: userid)
        navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("ChatViewController tableView Check")
        if let cell = tableview.dequeueReusableCell(withIdentifier: "ChatListTableViewCell", for: indexPath) as? ChatListTableViewCell{
            
            let arraymodel = self.array[indexPath.row]
            
            cell.imageview.kf.setImage(
                with: URL(string: arraymodel.photoUri ?? ""),
                placeholder: UIImage(named: "logo_only"))
            cell.titleLabel.text = arraymodel.name
            
            //TODO: 마지막 대화 보여지지 않는 오류 수정
            if chatArray.count != 0{
                let chatmodel = chatArray[indexPath.row]
                cell.lastMessageLabel.text = chatmodel.message
                cell.timeStampLabel.text = chatmodel.time
            }
            else{
                cell.lastMessageLabel.text = ""
                cell.timeStampLabel.text = ""
            }
            

            return cell
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 50
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
