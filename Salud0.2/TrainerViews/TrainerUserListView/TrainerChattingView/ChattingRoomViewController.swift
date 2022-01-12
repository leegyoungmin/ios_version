//
//  ChattingRoomViewController.swift
//  Salud0.2
//
//  Created by 이관형 on 2021/11/15.
//
import Foundation
import FirebaseAuth
import FirebaseDatabase
import SwiftUI
import KakaoSDKAuth


class ChattingRoomViewController:UIViewController{

    var userid:String
    var chats:[ChatModel] = []
    
    var username:String = ""
    var centercode:String = ""
    var trainername:String = ""
    
    
    init(userid:String){
        self.userid = userid
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var messageTextField:UITextField = {
        let messageTextField = UITextField()
        messageTextField.placeholder = "메시지를 작성하세요."
        messageTextField.backgroundColor = .white
        return messageTextField
    }()
    
    lazy var sendButton:UIButton = {
        let sendButton = UIButton()
        sendButton.tintColor = .purple
        sendButton.setImage(UIImage(systemName: "arrow.up.circle"), for: .normal)
        sendButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)

        return sendButton
    }()
    
    @objc func didTapSendButton(){
        //TODO: 전송 버튼 이벤트 처리
        SaveChattingRoom()
        SaveChattingData()
    }
    
    
    lazy var MessageTableView:UITableView = {
        let MessageTableView = UITableView()
        MessageTableView.delegate = self
        MessageTableView.dataSource = self
        MessageTableView.register(MyMessageTableViewCell.self, forCellReuseIdentifier: "MyMessageCell")
        MessageTableView.register(DestinationMessageTableViewCell.self, forCellReuseIdentifier: "DestinationMessageCell")
        MessageTableView.allowsSelection = false
        MessageTableView.separatorStyle = .none
        return MessageTableView
    }()
    
    lazy var MessageInputContainerView : UIView = {
        let MessageInputContainerView = UIView()
        MessageInputContainerView.backgroundColor = .white
        MessageInputContainerView.layer.borderWidth = 1
        MessageInputContainerView.layer.borderColor = UIColor.lightGray.cgColor
        MessageInputContainerView.layer.cornerRadius = 25
        
        [messageTextField,sendButton].forEach{
            MessageInputContainerView.addSubview($0)
        }
        
        messageTextField.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(10)
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalTo(sendButton.snp.leading)
        }
        sendButton.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.bottom.trailing.equalToSuperview()
            $0.width.height.equalTo(50)
        }
        return MessageInputContainerView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpNavigationBar()
        setUpLayout()
        getUserData(userid: self.userid)
//        fetchData()
    }
    private func setUpNavigationBar(){
        let navigationLeftButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(didTapBackButton))
        navigationItem.leftBarButtonItem = navigationLeftButton
        navigationController?.navigationBar.tintColor = .black
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.backgroundColor = .gray
        self.navigationController?.navigationBar.standardAppearance = navigationAppearance
        self.navigationController?.navigationBar.compactAppearance = navigationAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationAppearance
    }
    @objc func didTapBackButton(){
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.backgroundColor = .white
        self.navigationController?.navigationBar.standardAppearance = navigationAppearance
        self.navigationController?.navigationBar.compactAppearance = navigationAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationAppearance
        navigationController?.popViewController(animated: true)
    }
    
    private func setUpLayout(){
        [MessageTableView,MessageInputContainerView].forEach{
            view.addSubview($0)
        }
        MessageTableView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(MessageInputContainerView.snp.top).offset(5)
        }
        
        MessageInputContainerView.snp.makeConstraints{
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(5)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-5)
        }
    }
    //TODO: - KeyBoard 올라옴에 따른 뷰 위치 확인 및 수정

}

//Extensions
extension ChattingRoomViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chatting:ChatModel = self.chats[indexPath.row]
        
        if(chatting.receiver == userid){
            
            guard let mycell = MessageTableView.dequeueReusableCell(withIdentifier: "MyMessageCell", for: indexPath) as? MyMessageTableViewCell else{return UITableViewCell()}
            mycell.messageLabel.text = chatting.message
            mycell.timeStampLabel.text = chatting.time
            
            return mycell
        }
        else{
            guard let usercell = MessageTableView.dequeueReusableCell(withIdentifier: "DestinationMessageCell", for: indexPath) as? DestinationMessageTableViewCell else{return UITableViewCell()

            }
            usercell.messageLabel.text = chatting.message
            usercell.timeStampLabel.text = chatting.time
            usercell.nameLabel.text = chatting.receivername

            return usercell
        }
    }
}

extension ChattingRoomViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.chats.count
    }
}


extension ChattingRoomViewController{
    
    //User Name & Fitness Center Code
    func getUserData(userid:String){
        FirebaseDatabase.Database.database().reference()
            .child("User")
            .child(userid)
            .observeSingleEvent(of: .value){snapshot in
                print(snapshot)
                let values = snapshot.value as! [String:Any]
                guard let code = values["fitnessCode"] as? String,
                      let name = values["name"] as? String else {return}
                self.centercode = code
                self.username = name
                ///NavigstionBar title 유저 이름으로 변경
                self.navigationController?.title = self.username
                self.navigationItem.title = self.username
                self.fetchData()
            }
    }
    
    // Chatting Data
    func fetchData(){

        guard let currentid = FirebaseAuth.Auth.auth().currentUser?.uid else{return}
        FirebaseDatabase.Database.database().reference()
            .child("Chats")
            .child(self.centercode)
            .child(currentid)
            .child(self.userid)
            .observe(.value){snapshot in
                //TODO: 자식에 대한 Observe로 변경 고려
                self.chats = []
                for child in snapshot.children{
                    let snap  = child as! DataSnapshot
                    let values = snap.value as! [String:Any]
                    let chatmodel = ChatModel()
                    chatmodel.setValuesForKeys(values)
                    print(chatmodel)
                    self.chats.append(chatmodel)
                }
                
                self.MessageTableView.reloadData()
            }
        FirebaseDatabase.Database.database().reference()
            .child("Trainer")
            .child(currentid)
            .child("name")
            .observeSingleEvent(of: .value){ snapshot in
                guard let trainername = snapshot.value as? String else{return}
                self.trainername = trainername
            }
    }
    
    func SaveChattingRoom(){
        guard let trainerid = Auth.auth().currentUser?.uid else {return}
        Database.database().reference()
            .child("ChatList")
            .child(centercode)
            .child(trainerid)
            .child(userid)
            .observeSingleEvent(of: .value){snapshot in
                if !snapshot.exists(){
                    snapshot.ref.child("uid").setValue(self.userid)
                }
                
            }
    }
    
    func SaveChattingData(){
        guard let trainerid = Auth.auth().currentUser?.uid,
              let message:String = messageTextField.text else{ return }
        let Dateformatter = DateFormatter()
        Dateformatter.dateFormat = "MM-dd"
        let current_date = Dateformatter.string(from:Date())
        
        let Timeformatter = DateFormatter()
        Timeformatter.dateFormat = "HH:mm"
        let current_time = Timeformatter.string(from:Date())
        
        let MessageData : Dictionary<String, Any> = [
            "message" : message,
            "read" : "false",
            "receiver" : userid,
            "receivername":username,
            "sender" : trainerid,
            "sendername":trainername,
            "date":current_date,
            "time":current_time
        ]
        
        Database.database().reference()
            .child("Chats")
            .child(centercode)
            .child(trainerid)
            .child(userid)
            .childByAutoId()
            .setValue(MessageData){(error,ref) in
                if error == nil{
                    self.messageTextField.text = ""
                    self.messageTextField.placeholder = "메시지를 입력하세요."
                    
                    let indexpath = IndexPath(item: self.chats.count-1, section: 0)
                    self.MessageTableView.scrollToRow(at: indexpath, at: .bottom, animated: true)
                }
                else{
                    //TODO: Alert으로 에러 처리 하기
                }
            }
    }

    
}


struct ChattingRoomViewController_Previews:PreviewProvider{
    static var previews: some View{
        UIViewControllerPreview{
            let controller = ChattingRoomViewController(userid: "example")
            return controller
        }
    }

}
