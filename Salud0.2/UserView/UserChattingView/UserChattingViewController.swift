//
//  UserChattingViewController.swift
//  Salud0.2
//
//  Created by 이경민 on 2021/11/18.
//

import Foundation
import UIKit
import SnapKit
import FirebaseAuth
import FirebaseDatabase
import Kingfisher
import SwiftUI

final class UserChattingViewController:UIViewController{
    
    let uid = Auth.auth().currentUser?.uid ?? "default"
    var uidName: String?
    var fitnessCode: String?
    var trainerName: String?
    var trainerid:String
    var trainerModel: TrainerChatModel?
    var chatArray: [ChatModel] = []
    var tableview: UITableView!
    var isChatted: Bool?
    var isread: Bool?
    var bottomConstraint: NSLayoutConstraint?
    var topConstraint: NSLayoutConstraint?
    
    init(trainerid:String){
        self.trainerid = trainerid
        print("trainer id in initialize \(self.trainerid)")
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var TableView:UITableView = {
        let tableview = UITableView()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(MyMessageTableViewCell.self, forCellReuseIdentifier: "MyMessageCell")
        tableview.register(DestinationMessageTableViewCell.self, forCellReuseIdentifier: "DestinationMessageCell")
        tableview.separatorStyle = .none
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = UITableView.automaticDimension
        tableview.allowsSelection = false
        //        tableview.keyboardDismissMode = .onDrag
        return tableview
    }()
    
    private let messageTextField: UITextField = {
        let message = UITextField()
        message.placeholder = "메시지를 작성하세요."
        message.backgroundColor = .white
        message.borderStyle = .none
        return message
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.up.circle"), for: .normal)
        button.tintColor = .purple
        button.addTarget(self, action: #selector(createRoom(_:)), for: . touchUpInside)
        return button
    }()
    
    private let messageInputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.purple.cgColor
        view.layer.cornerRadius = 15
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        getTrainerInfo()
        setUpNavigationBar()
        setupInputComponents()
        setUpLayouts()
        checkIsChatted()
    }
    
}

//UI 작업 함수들
extension UserChattingViewController{
    //Setting NavigationBar Title & Layout
    func setUpNavigationBar(){
        navigationItem.title = trainerName
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        let leftbaritem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.backward"),
            style: .plain,
            target: self,
            action: #selector(didTapNavigationLeftButton))
        leftbaritem.tintColor = .black
        navigationController?.navigationBar.barTintColor = .white.withAlphaComponent(30)
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = leftbaritem
    }
    
    @objc func didTapNavigationLeftButton(){
        navigationController?.dismiss(animated: true)
    }
    
    
    //Base Layout Setting
    func setUpLayouts(){
        [
            TableView,
            messageInputContainerView
        ].forEach{
            view.addSubview($0)
        }
        
        setupInputComponents()
        
        TableView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(messageInputContainerView.snp.top)
        }
        messageInputContainerView.snp.makeConstraints{
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-5)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-10)
            $0.height.equalTo(50)
        }
        
        fitnessCode = UserDefaults.standard.string(forKey: "fitnessCode")
        uidName = UserDefaults.standard.string(forKey: "name")
    }
    //User Input TextEditView Setting
    func setupInputComponents(){
        messageInputContainerView.snp.makeConstraints{
            $0.width.equalTo(view.frame.width)
        }
        [messageTextField,sendButton].forEach{
            messageInputContainerView.addSubview($0)
        }
        messageTextField.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(10)
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.trailing.equalTo(sendButton.snp.leading)
        }
        sendButton.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.width.equalTo(50)
            $0.height.equalTo(50)
        }
    }
    
    
    @objc func didTapTextView(){
        print("clicked Text Button")
        dismiss(animated: true)
    }
    
    
    
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    @objc func createRoom(_ sender: UIButton){
        guard self.messageTextField.text != "" else{
            return
        }
        
        let formatter = DateFormatter()
        let date = DateFormatter()
        formatter.dateFormat = "HH:mm"
        date.dateFormat = "MM-dd"
        
        let current_time_string = formatter.string(from: Date())
        let current_date_string = date.string(from: Date())
        
        FirebaseDatabase.Database.database().reference()
            .child("ChatList")
            .child(self.fitnessCode!)
            .child(self.trainerid)
            .child(uid)
            .observeSingleEvent(of: .value){snapshot in
                if !snapshot.exists(){
                    snapshot.ref.child("uid").setValue(self.uid)
                }
                
            }
        
        let value: Dictionary<String, Any> = [
            "message": messageTextField.text!,
            "read": "false",
            "receiver": trainerid,
            "receivername": trainerName,
            "sender": uid,
            "sendername": uidName,
            "date": current_date_string,
            "time": current_time_string
        ]
        
        Database.database().reference().child("Chats").child(fitnessCode!)
            .child(trainerid)
            .child(uid)
            .childByAutoId()
            .setValue(value, withCompletionBlock: { (err, ref) in
                print("setValued")
                self.messageTextField.text = ""
                self.messageTextField.placeholder = "메시지를 입력하세요."
            })
        getMessageList()
    }
    
    func checkIsChatted(){
        print("checkIsChatted")
        print(fitnessCode!)
        print("trainer id in checkIs Chatting \(trainerid)")
        
        Database.database().reference().child("ChatList").child(fitnessCode!)
            .child(trainerid).observeSingleEvent(of: .value, with: {snap in
                let values = snap.value
                if values != nil{
                    //TODO: 오류 발생
                    guard let dic = values as? [String: [String:String]] else{return}
                    for index in dic{
                        if index.key == self.uid{
                            print("checkChattingRoom in \(index.key)")
                            print("checkChattingRoom in \(index.value)")
                            self.isChatted = true
                            self.getTrainerInfo()
                            break
                        }
                        else{ self.isChatted = false}
                    }
                }
                else{
                    self.dismiss(animated: true)
                }
            })
    }
    
    func getTrainerInfo(){
        print("getTrainerInfo")
        Database.database().reference().child("Trainer").child(self.trainerid)
            .observeSingleEvent(of: .value, with: { snap in
                self.trainerModel = TrainerChatModel()
                print("check1")
                if let snapshotDic = snap.value as? [String: Any]{
                    self.trainerModel?.setValuesForKeys(snapshotDic)
                    guard let trainername = self.trainerModel?.name as? String else{return}
                    self.trainerName = trainername
                    self.navigationItem.title = self.trainerName
                    print(trainername)
                    self.getMessageList()
                }
            })
    }
    
    
    func getMessageList(){
        print("getMessageList")
        Database.database().reference().child("Chats").child(fitnessCode!).child(trainerid)
            .child(self.uid)
            .observe(.value, with: { snap in
                self.chatArray.removeAll()
                for child in snap.children{
                    let fchild = child as! DataSnapshot
                    let chatModel = ChatModel()
                    chatModel.setValuesForKeys(fchild.value as! [String: Any])
                    if fchild.childSnapshot(forPath: "read").value as? Bool == false{
                        //TODO: true로 변경
                    }
                    self.chatArray.append(chatModel)
                    print(chatModel)
                }
                DispatchQueue.main.async{
                    self.TableView.reloadData()
                    //                    self.TableView.scrollToRow(at: IndexPath(item: self.chatArray.count - 1, section: 0), at: UITableView.ScrollPosition.bottom, animated: false)
                }
            })
    }
}

extension UserChattingViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (self.chatArray[indexPath.row].sender == uid){
            guard let mycell = TableView.dequeueReusableCell(withIdentifier: "MyMessageCell", for: indexPath) as? MyMessageTableViewCell else{return UITableViewCell()}
            mycell.messageLabel.text = chatArray[indexPath.row].message
            mycell.timeStampLabel.text = chatArray[indexPath.row].time
            
            return mycell
        }
        else{
            guard let mycell = TableView.dequeueReusableCell(withIdentifier: "DestinationMessageCell", for: indexPath) as? DestinationMessageTableViewCell else {
                return UITableViewCell()
            }
            mycell.messageLabel.text = chatArray[indexPath.row].message
            mycell.timeStampLabel.text = chatArray[indexPath.row].time
            mycell.nameLabel.text = self.trainerName
            mycell.profileImage.kf.setImage(
                with: URL(string: self.trainerModel?.photoUri ?? ""),
                placeholder: UIImage(named: "logo_only")
            )
            
            return mycell
        }
        
    }
    
}
extension UserChattingViewController: UIGestureRecognizerDelegate{
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

struct UserChattingViewControllerPreviews:PreviewProvider{
    static var previews: some View{
        UIViewControllerPreview{
            let viewcontroller = UserChattingViewController(trainerid: "kakao:1967260938")
            return viewcontroller
        }
    }
}
