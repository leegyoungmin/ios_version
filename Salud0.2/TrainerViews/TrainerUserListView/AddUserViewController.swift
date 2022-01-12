//
//  AddUserViewController.swift
//  Salud0.2
//
//  Created by 이관형 on 2021/11/09.
//

import Foundation
import UIKit
import SnapKit
import FirebaseDatabase
import FirebaseAuth
import SwiftUI

class AddUserViewController: UIViewController{
    
    
    let okAction = UIAlertAction(title: "확인", style: .default){ (action) in
        print("Pressed OKAction")
        UserDefaults.standard.removeObject(forKey: "UserPhoneCheck")
        UserDefaults.standard.set(true, forKey: "UserPhoneCheck")
        print(UserDefaults.standard.bool(forKey: "UserPhoneCheck"))
    }
    let noAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel){ (action) in
        print("Pressed NOAction")
        UserDefaults.standard.removeObject(forKey: "UserPhoneCheck")
        UserDefaults.standard.set(false, forKey: "UserPhoneCheck")
        print(UserDefaults.standard.bool(forKey: "UserPhoneCheck"))
    }
    
    
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "회원추가하기"
        label.font = label.font.withSize(20)
        return label
        
    }()
    
    
    
    private let addUserLabel : UITextField = {
       let add = UITextField()
        add.text = "휴대전화"
        add.borderStyle = .roundedRect
        add.backgroundColor = .purple
        add.textColor = .white
        add.textAlignment = .center
        add.isUserInteractionEnabled = false
        return add
    }()
    private let addUserTextField: UITextField = {
        let add = UITextField()
        add.placeholder = "회원의 휴대전화 11자리를 적으세요."
        add.borderStyle = .roundedRect
        add.addTarget(self, action: #selector(textFieldShouldReturn(_:)), for: .editingDidEndOnExit)
        add.keyboardType = .numberPad
        return add
    }()

    private let addUserConfirmButton: UIButton = {
        let confirm = UIButton()
        confirm.setTitle("인증", for: .normal)
        confirm.addTarget(self, action: #selector(checkUser(_:)), for: .touchUpInside)
        confirm.translatesAutoresizingMaskIntoConstraints = false
        confirm.titleLabel?.font = UIFont(name: "GillSans-Italic", size: 20)
        confirm.setTitleColor(.black, for: .normal)
        confirm.backgroundColor = .white
        confirm.layer.cornerRadius = 10
        confirm.layer.borderWidth = 1
        return confirm
    }()
    
    private let addUserConfirmMessage: UITextField = {
        let message = UITextField()
        message.translatesAutoresizingMaskIntoConstraints = false
        message.font = UIFont(name: "GillSans-Italic", size: 15)
        message.isHidden = true
        return message
    }()
    
    private let addButton: UIButton = {
        let add = UIButton()
        add.setTitle("추가하기", for: .normal)
        add.backgroundColor = .purple
        add.setTitleColor(.white, for: .normal)
        add.addTarget(self, action: #selector(confirm(_:)), for: .touchUpInside)
        return add
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(label)
        view.addSubview(addUserLabel)
        view.addSubview(addUserTextField)
        view.addSubview(addUserConfirmButton)
        view.addSubview(addUserConfirmMessage)
        view.addSubview(addButton)
        
        label.snp.makeConstraints{ (make) in
            make.top.equalTo(self.view).offset(50)
            make.centerX.equalTo(self.view)
        }
        addUserLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(self.view).offset(220)
            make.left.equalTo(self.view).offset(20)
            make.width.equalTo(80)
        }
        addUserTextField.snp.makeConstraints{ (make) in
            make.left.equalTo(addUserLabel.snp.right)
            make.top.equalTo(self.view).offset(220)
            make.width.equalTo(200)
        }
        addUserConfirmButton.snp.makeConstraints{ (make) in
            make.left.equalTo(addUserTextField.snp.right).offset(30)
            make.top.equalTo(self.view).offset(220)
            make.width.equalTo(50)
        }
        addUserConfirmMessage.snp.makeConstraints{ (make) in
            make.top.equalTo(addUserTextField.snp.bottom).offset(10)
            make.centerX.equalTo(self.view)
        }
        addButton.snp.makeConstraints{ (make) in
            make.bottom.centerX.equalTo(self.view)
        }
        
    }
}


extension AddUserViewController{
    //UITextField가 수정이 시작되면 동작
    @objc func textFieldDidBeginEditing(_ sender: UITextField){
        print("textFieldDidBeginEditing: \((sender .text) ?? "Empty")")
    }
    
    //UITextField가 수정이 완료되면 동작
    @objc func textFieldDidEndEditing(_ sender: UITextField) {
        print("textFieldDidEndEditing: \((sender.text) ?? "Empty")")
    }
    
    
    //키보드에 완료버튼을 눌렀을 시 동작
    @objc func textFieldShouldReturn(_ sender: UITextField) -> Bool {
        print("textFieldShouldReturn \((sender.text) ?? "Empty")")
        
        addUserTextField.resignFirstResponder()
        
        return true
    }
    
    
    @objc func confirm(_ sender: UIButton){
        print("confirm is pressed")
        print(UserDefaults.standard.bool(forKey: "UserPhoneCheck"))
        let uid = Auth.auth().currentUser?.uid
        if self.addUserTextField.text!.count != 11{
            self.addUserConfirmMessage.text = "휴대전화 11자리를 명확히 작성해주세요."
            self.addUserConfirmMessage.isHidden = true
        }
        else if self.addUserTextField.text!.count == 11{
            let checkUserPhone = UserDefaults.standard.bool(forKey: "UserPhoneCheck")
            if checkUserPhone == true{
                print("func Confirm ==> checkUserPhone == true")
                print(UserDefaults.standard.string(forKey: "UserName") ?? "default")
                Database.database().reference().child("Trainer").child(uid!)
                    .child("trainee")
                    .updateChildValues([UserDefaults.standard.string(forKey: "UserId")! : UserDefaults.standard.string(forKey: "UserName")!])
                    
                    
//                    .setValue(UserDefaults.standard.string(forKey:"UserName") ?? "default")
                Database.database().reference().child("User")
                    .child(UserDefaults.standard.string(forKey: "UserId")!)
                    .child("trainer")
                    .setValue(uid!)
                let presentingVC = self.presentingViewController
                var tempList: [String] = []
                Database.database().reference().child("Trainer").child(uid!).child("trainee")
                    .observeSingleEvent(of: .value, with: {snapshot in
                        tempList.removeAll()
                        for child in snapshot.children{
                            let fchild = child as! DataSnapshot
                            tempList.append(fchild.key)
                        }
                        
                    })
                print("AddUserViewController In TempList == \(tempList)")
                UserDefaults.standard.set(tempList, forKey: "tempList")
                
                let vc = UIHostingController(rootView: TrainerBaseView())
                vc.modalPresentationStyle = .fullScreen
                self.dismiss(animated: true){
                    presentingVC?.present(vc, animated: false)
                }
            }
            else if checkUserPhone == false{
                print("checkUserPhone == false ====> \(checkUserPhone)")
//                let presentingVC = self.presentingViewController
//                let vc = TrainerUserListView()
//                vc.modalPresentationStyle = .fullScreen
//                self.dismiss(animated: true){
//                    presentingVC?.present(vc, animated: false)
//                }
            }
            else{
                print("인증버튼을 누르지 않음.")
                
            }
            
        }
    }
    
    
    
    @objc func checkUser(_ sender: UIButton){
        let phone = addUserTextField.text!
        print("===============this line is checkUserfuntion===============")
        Database.database().reference().child("User")
            .observeSingleEvent(of: .value, with: { (snapshot) in
                let values = snapshot.value
                let dic = values as! [String: [String:Any]]
                for index in dic{
                    if (index.value["phone"] as! String) == phone{
                        print("phonenum is Same")
                        UserDefaults.standard.set(index.value["phone"], forKey: "tempUserPhone")
                        UserDefaults.standard.removeObject(forKey: "UserId");
                        UserDefaults.standard.set(index.value["uid"], forKey: "UserId")
                        UserDefaults.standard.set(index.value["name"], forKey: "UserName")
                        
                        print("================UserInfo================")
                        print(index.value["phone"] ?? "default")
                        print(index.value["age"] ?? "default")
                        let name = index.value["name"]
                        let age = index.value["age"]
                        let alert = UIAlertController(title: "확인", message: "이름:\(name!)\n나이:\(age!)가 맞습니까?", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(self.okAction)
                        alert.addAction(self.noAction)
                        self.present(alert, animated: true, completion: nil)
                        
                        break
                    }
                }
            })
    }
}
