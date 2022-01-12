//
//  PeopleViewController.swift
//  Salud0.2
//
//  Created by 이관형 on 2021/11/08.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth
import SwiftUI
import SnapKit


class TrainerUserListViewController: UIViewController{
    var userList : [UserListModel] = []
    var userIdList: [String] = []
    let uid = Auth.auth().currentUser?.uid
  
    
    private let noneFieldText : UILabel = {
        let text = UILabel()
        text.isUserInteractionEnabled = false
        text.numberOfLines = 2
        text.textAlignment = .center
        return text
    }()
    
    lazy var tableview:UITableView = {
        let tableview = UITableView()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorStyle = .singleLine
        tableview.separatorInset = .zero
        tableview.register(TrainerUserListViewCell.self, forCellReuseIdentifier: "TrainerUserListViewCell")
        tableview.allowsSelection = true
        return tableview
    }()
    
    override func loadView() {
        super.loadView()
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        navigationController?.navigationBar.isHidden = true
        makeLayout()
        getUserIdList()
        print("UserId List in viewDidLoad \(self.userIdList)")
    }
    
    func makeLayout(){
        [
            noneFieldText,
            tableview
        ].forEach{
            view.addSubview($0)
        }
        tableview.snp.makeConstraints{
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalToSuperview()
        }
        
    }
    
    
    private func getUserIdList(){
        guard let trainerid = Auth.auth().currentUser?.uid else{return}
        Database.database().reference()
            .child("Trainer")
            .child(trainerid)
            .child("trainee")
            .observeSingleEvent(of: .value){snapshot in
                if snapshot.value as? String != "default"{
                    let value = snapshot.value
                    let userdict = value as? [String:String]?
                    guard let userdict = userdict as? [String:String] else{return}
                                       
                    userdict.forEach{
                        self.userIdList.append($0.key)
                        print("Firebase Trainer UserId List \($0.key)")
                    }
                    
                    
                }
                self.userIdList.forEach{
                    print("user id in getUserList \($0)")
                    var usermodel = UserListModel()
                    Database.database().reference()
                        .child("User")
                        .child($0)
                        .observeSingleEvent(of: .value){snapshot in
                            usermodel.userName = snapshot.childSnapshot(forPath: "name").value as? String
                            usermodel.userImageString = snapshot.childSnapshot(forPath: "photoUri")
                                .value as? String
                            usermodel.messageText = "default"
                            self.userList.append(usermodel)
                        }
                }
            }
    }
}

//TableView UI Setting
extension TrainerUserListViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}

//TableView Data Setting
extension TrainerUserListViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TrainerUserListViewCell",for: indexPath) as? TrainerUserListViewCell else{
            return UITableViewCell()
        }
        
        cell.userName.text = self.userList[indexPath.row].userName
        print("UserImageString in UserList Cell \(userList[indexPath.row].userImageString ?? "")")
        cell.userImage.kf.setImage(with: URL(string: userList[indexPath.row].userImageString ?? ""))
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let usermodel = userList[indexPath.row]
        let userid = userIdList[indexPath.row]
        let hostingView = UIHostingController(rootView:TrainerUserProfileView(usermodel: usermodel,userid: userid))
        self.navigationController?.pushViewController(hostingView, animated: true)
    }
}

struct TrainerUserListViewControllerPreviews:PreviewProvider{
    static var previews: some View{
        UIViewControllerPreview{
            let controller = TrainerUserListViewController()
            return controller
        }
    }
}
