//
//  MainViewController.swift
//  Salud0.2
//
//  Created by 이관형 on 2021/10/16.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import NaverThirdPartyLogin
import Alamofire
import FirebaseAuth
import FirebaseDatabase
import Firebase
import SnapKit
import SwiftUI



class ConstantMoreInfo: UIViewController{
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    let ref = Database.database().reference()
    let name = UserDefaults.standard.string(forKey: "name") ?? "default"
    let email = UserDefaults.standard.string(forKey: "email") ?? "default"
    let loginApi = UserDefaults.standard.string(forKey: "LoginApi") ?? "default"
    let uid: String = UserDefaults.standard.string(forKey: "Uid") ?? "default"
    let okAction = UIAlertAction(title: "OK", style: .default) { (action) in }
    
    var classification: String?
    
    //    Test용 로그아웃
    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그아웃", for: .normal)
        button.addTarget(self, action: #selector(touchUpLogoutButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    //userType View Create
    
    private let UserTypeLabel: UILabel = {
        let UserTypeLabel = UILabel()
        UserTypeLabel.text = "회원 구분"
        UserTypeLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        UserTypeLabel.textColor = .purple
        UserTypeLabel.textAlignment = .center
        UserTypeLabel.isUserInteractionEnabled = false
        return UserTypeLabel
    }()
    
    private let trainerButton: UIButton = {
        let trainer = UIButton(type: .system)
        trainer.setTitle("트레이너", for: .normal)
        trainer.addTarget(self, action: #selector(touchColorChange(_:)), for: .allTouchEvents)
        trainer.translatesAutoresizingMaskIntoConstraints = false
        trainer.titleLabel?.font = UIFont(name: "GillSans-Italic", size: 20)
        trainer.setTitleColor(.black, for: .normal)
        trainer.backgroundColor = UIColor.clear
        trainer.layer.cornerRadius = 10
        trainer.layer.borderWidth = 1
        return trainer
    }()
    
    
    private let userButton: UIButton = {
        let user = UIButton(type: .system)
        user.setTitle("회원", for: .normal)
        user.addTarget(self, action: #selector(touchColorChange(_:)), for: .allTouchEvents)
        user.translatesAutoresizingMaskIntoConstraints = false
        //        sex.frame = CGRect(x: 150, y: 300, width: 10, height: 10)
        user.titleLabel?.font = UIFont(name: "GillSans-Italic", size: 20)
        user.setTitleColor(.black, for: .normal)
        user.backgroundColor = UIColor.white
        user.layer.cornerRadius = 10
        user.layer.borderWidth = 1
        return user
    }()
    //End UserType Created
    
    private let birthLabel: UILabel = {
        let birth = UILabel()
        birth.text = "생년월일"
        birth.font = .systemFont(ofSize: 20, weight: .semibold)
        birth.textColor = .purple
        birth.textAlignment = .center
        birth.isUserInteractionEnabled = false
        return birth
    }()
    
    private let birthdayTextField: UITextField = {
        let birth = UITextField()
        birth.borderStyle = .roundedRect
        birth.placeholder = "앞 6자리"
        birth.addTarget(self, action: #selector(textFieldShouldReturn(_:)), for: .editingDidEndOnExit)
        birth.keyboardType = .numberPad
        return birth
    }()
    
    private let birthdayConnection: UITextView = {
        let connect = UITextView()
        connect.text = "-"
        return connect
    }()
    
    private let Sexnum: UITextField = {
        let sex = UITextField()
        sex.addTarget(self, action: #selector(textField(_:shouldChangeCharactersIn:replacementString:)), for: .editingDidEndOnExit)
        sex.borderStyle = .roundedRect
        sex.keyboardType = .numberPad
        return sex
    }()
    
    private let endbirthdayConnection: UITextField = {
        let connect = UITextField()
        connect.isSecureTextEntry = true
        connect.text = "000000"
        return connect
    }()
    
    private let fitnessCodeConfirmMessage: UILabel = {
        let message = UILabel()
        message.text = "코드가 일치하지 않습니다. 가맹점에 문의하세요."
        message.textColor = .red
        message.translatesAutoresizingMaskIntoConstraints = false
        message.font = UIFont(name: "GillSans-Italic", size: 10)
        message.isHidden = true
        return message
    }()
    private let phoneLabel: UILabel = {
        let phone = UILabel()
        phone.text = "휴대전화"
        phone.textColor = .purple
        phone.font = .systemFont(ofSize: 20, weight: .semibold)
        phone.textAlignment = .center
        phone.isUserInteractionEnabled = false
        return phone
    }()
    
    private let phoneText: UITextField = {
        let phone = UITextField()
        phone.borderStyle = .roundedRect
        phone.placeholder = "-없이 11자리를 입력하세요."

        phone.addTarget(self, action: #selector(textFieldShouldReturn(_:)), for: .editingDidEndOnExit)
        phone.keyboardType = .phonePad
        return phone
    }()
    
    private let codeLabel: UILabel = {
        let code = UILabel()
        code.text = "회원코드"
        code.textColor = .purple
        code.font = .systemFont(ofSize: 20, weight: .bold)
        code.textAlignment = .center
        code.isUserInteractionEnabled = false
        return code
    }()
    
    private let codeText: UITextField = {
        let code = UITextField()
        code.borderStyle = .roundedRect
        code.placeholder = ""
        code.addTarget(self, action: #selector(textFieldShouldReturn(_:)), for: .editingDidEndOnExit)
        code.keyboardType = .numberPad
        return code
    }()
    
    private let fitnessCodeConfirmButton: UIButton = {
        let main = UIButton()
        main.setTitle("인증", for: .normal)
        main.addTarget(self, action: #selector(confirm(_:)),for: .touchUpInside)
        main.translatesAutoresizingMaskIntoConstraints = false
        main.titleLabel?.font = UIFont(name: "GillSans-Italic", size: 20)
        main.setTitleColor(.black, for: .normal)
        main.backgroundColor = UIColor.white
        main.layer.cornerRadius = 10
        main.layer.borderWidth = 1
        return main
    }()
    
    private let mainPageButton: UIButton = {
        
        let main = UIButton()
        main.setTitle("회원가입완료", for: .normal)
        main.addTarget(self, action: #selector(nextPage(_:)), for: .touchUpInside)
        main.translatesAutoresizingMaskIntoConstraints = false
        main.titleLabel?.font = UIFont(name: "GillSans-Italic", size: 20)
        main.setTitleColor(.black, for: .normal)
        main.backgroundColor = UIColor.white
        main.layer.cornerRadius = 10
        main.layer.borderWidth = 1
        return main
    }()
    
}



extension ConstantMoreInfo{
    
    @objc func confirm(_ sender: UIButton){
        if self.codeText.text!.count != 6{
            self.fitnessCodeConfirmMessage.text = "코드 6자리를 입력해주세요."
            self.fitnessCodeConfirmMessage.isHidden = false
        }
        else{
            ref.child("Center").observeSingleEvent(of: .value, with: { (snapshot) in
                let values = snapshot.value
                print("========\(values!)")
                let dic = values as! [String: [String:Any]]
                for index in dic{
                    if (index.value["code"] as! String) == self.codeText.text{
                        print("Code Is Correct")
                        UserDefaults.standard.removeObject(forKey: "confirm")
                        UserDefaults.standard.set(true, forKey: "confirm")
                        self.fitnessCodeConfirmMessage.text = "코드인증이 되었습니다."
                        self.fitnessCodeConfirmMessage.textColor = .blue
                        self.fitnessCodeConfirmMessage.isHidden = false
                    }
                    else{
                        UserDefaults.standard.removeObject(forKey: "confirm")
                        UserDefaults.standard.set(false, forKey: "confirm")
                        self.fitnessCodeConfirmMessage.text = "코드가 일치하지 않습니다. 가맹점에 문의하세요."
                        self.fitnessCodeConfirmMessage.isHidden = false
                    }
                }
            })
        }
    }
    
    @objc func nextPage(_ sender: UIButton){
        var sexnum: String = Sexnum.text ?? "default"
        print("nextPage In sexnum ==\(sexnum)")
        let birth: String = birthdayTextField.text ?? "default"
        let phonenum: String = phoneText.text ?? "default"
        let classification: String = UserDefaults.standard.string(forKey: "classification") ?? "default"
        let email: String = UserDefaults.standard.string(forKey: "email") ?? "default"
        let loginApi: String = UserDefaults.standard.string(forKey: "LoginApi") ?? "default"
        let name: String = UserDefaults.standard.string(forKey: "name") ?? "default"
        let uid: String = UserDefaults.standard.string(forKey: "Uid") ?? "default"
        
        
        let firstbirthIndex = birth.index(birth.startIndex, offsetBy: 0)
        let lastbirthIndex = birth.index(birth.startIndex, offsetBy: 2)
        let first_birth_date_Index = birth.index(birth.startIndex, offsetBy: 2)
        let last_birth_date_Index = birth.index(birth.startIndex, offsetBy: 6)
        let birthDate = birth[first_birth_date_Index..<last_birth_date_Index]
        let birthDateString = String(birthDate)
        let birthyear = birth[firstbirthIndex..<lastbirthIndex]
        let birthYearString = String(birthyear)
        var birthInt: Int = Int(birthyear) ?? 0
        let formatter_year = DateFormatter()
        formatter_year.dateFormat = "yyyy"
        let current_year_string = formatter_year.string(from: Date())
        print(current_year_string)
        birthInt = 1900 + birthInt
        print("GoogleInfo in age === \(birthInt)")
        let birthString = String(birthInt)
        print(Int(current_year_string) ?? 0)
        let realAge = Int(current_year_string)! - birthInt
        print("GoogleInfo in realAge ====\(realAge)")
        
        
        guard let uid = FirebaseAuth.Auth.auth().currentUser?.uid as? String else{return}
        print(uid)
        
        if classification == "trainer"{
            if sexnum == "1" || sexnum == "3"{
                sexnum = "0"
                checkInfo(birth: birth, sexnum: sexnum, phonenum: phonenum, classification: classification, birthString: birthString, birthDate: birthDateString, birthYear: birthYearString, email: email, loginApi: loginApi, name: name, uid: uid)
                let vc = UIHostingController(rootView: TrainerBaseView())
                //                weak var presentingVC = presentingViewController
                vc.modalPresentationStyle = .fullScreen
                //                self.dismiss(animated: true){
                //                    presentingVC?.present(vc, animated: true)
                //                }
                present(vc, animated: true)
                
                //                weak var presentingVC = self.presentingViewController
                //                let vc = AddUserViewController()
                //                vc.modalPresentationStyle = .fullScreen
                //                self.dismiss(animated: true){
                //                    presentingVC?.present(vc, animated: true)
                //                }
                
            }
            else if sexnum == "2" || sexnum == "4"{
                sexnum = "1"
                checkInfo(birth: birth, sexnum: sexnum, phonenum: phonenum, classification: classification, birthString: birthString, birthDate: birthDateString, birthYear: birthYearString, email: email, loginApi: loginApi, name: name, uid: uid)
                let vc = UIHostingController(rootView: TrainerBaseView())
                //                weak var presentingVC = presentingViewController
                vc.modalPresentationStyle = .fullScreen
                //                self.dismiss(animated: true){
                //                    presentingVC?.present(vc, animated: true)
                //                }
                present(vc, animated: true)
            }
        }
        else if classification == "user"{
            if sexnum == "1" || sexnum == "3"{
                sexnum = "0"
                checkInfo(birth: birth, sexnum: sexnum, phonenum: phonenum, classification: classification, birthString: birthString, birthDate: birthDateString, birthYear: birthYearString, email: email, loginApi: loginApi, name: name, uid: uid)
                let vc = UserMoreInfo()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
            else if sexnum == "2" || sexnum == "4"{
                sexnum = "1"
                
                checkInfo(birth: birth, sexnum: sexnum, phonenum: phonenum, classification: classification, birthString: birthString, birthDate: birthDateString, birthYear: birthYearString, email: email, loginApi: loginApi, name: name, uid: uid)
                let vc = UserMoreInfo()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
                
            }
        }
        else{
            let alert = UIAlertController(title: "실패", message: "사용자 분류를 선택해주세요.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(okAction)
            present(alert, animated: false, completion: nil)
        }
    }
    
    
    func checkInfo(birth: String!, sexnum: String!, phonenum: String!, classification: String!, birthString: String!, birthDate: String!, birthYear: String!, email: String!, loginApi: String!, name: String!, uid: String!){
        let ref = Database.database().reference()
        print("Userid in CheckInfo \(uid)")
        
        //TODO: 1. 생년월일 확인
        if birth.count == 6{
            print(birth!)
            print(birth.count)
            //TODO: 2. 주민번호 뒷자리 1,2,3,4 외에는 오류
            if sexnum == "0" || sexnum == "1"
            {
                //                print("checkInfo In sexnum === \(sexnum)")
                //TODO: 3. 핸드폰번호 11자리 외에는 오류
                if phonenum.count == 11{
                    if self.codeText.text!.count != 6{
                        self.fitnessCodeConfirmMessage.text = "코드 6자리를 입력해주세요."
                        self.fitnessCodeConfirmMessage.isHidden = false
                    }
                    else{
                        ref.child("Center").observeSingleEvent(of: .value, with: { (snapshot) in
                            let values = snapshot.value
                            print("========\(values!)")
                            let dic = values as! [String: [String:Any]]
                            for index in dic{
                                if (index.value["code"] as! String) == self.codeText.text{
                                    print("Code Is Correct In GoogleInfo")
                                    UserDefaults.standard.removeObject(forKey: "confirm")
                                    UserDefaults.standard.set(true, forKey: "confirm")
                                    self.fitnessCodeConfirmMessage.text = "코드인증이 되었습니다."
                                    self.fitnessCodeConfirmMessage.textColor = .blue
                                    self.fitnessCodeConfirmMessage.isHidden = false
                                    var baseInfo = [String: String]()
                                    
                                    baseInfo["age"] = birthString
                                    baseInfo["birthday"] = birthDate
                                    baseInfo["birthyear"] = birthYear
                                    baseInfo["email"] = email
                                    baseInfo["gender"] = sexnum
                                    baseInfo["loginApi"] = loginApi
                                    baseInfo["name"] = name
                                    baseInfo["phone"] = phonenum
                                    baseInfo["status"] = "offline"
                                    baseInfo["photoUri"] = "default"
                                    baseInfo["uid"] = uid
                                    baseInfo["fitnessCode"] = self.codeText.text
                                    
                                    if classification == "user"{
                                        baseInfo["trainer"] = "default"
                                        baseInfo["division"] = "user"
                                        ref.child("User").child(uid).setValue(baseInfo)
                                        ref.child("Center").child(self.codeText.text!).child("User").child(uid).setValue(uid)
                                        ref.child("Classification").child(uid).setValue("user")
                                        UserDefaults.standard.set(uid, forKey: "uid")
                                        UserDefaults.standard.set(self.codeText.text, forKey: "fitnessCode")
                                        
                                    }
                                    
                                    else if classification == "trainer"{
                                        baseInfo["division"] = "trainer"
                                        baseInfo["trainee"] = "default"
                                        
                                        ref.child("Trainer").child(uid).setValue(baseInfo)
                                        ref.child("Center").child(self.codeText.text!).child("Trainer").child(uid).setValue(uid)
                                        ref.child("Classification").child(uid).setValue("trainer")
                                        UserDefaults.standard.set(uid, forKey: "uid")
                                        UserDefaults.standard.set(self.codeText.text, forKey: "fitnessCode")
                                    }
                                    
                                }
                                else{
                                    UserDefaults.standard.removeObject(forKey: "confirm")
                                    UserDefaults.standard.set(false, forKey: "confirm")
                                    self.fitnessCodeConfirmMessage.text = "코드가 일치하지 않습니다. 가맹점에 문의하세요."
                                    self.fitnessCodeConfirmMessage.isHidden = false
                                }
                            }
                        })
                    }
                }
                else{
                    //TODO: 3.에 대한 오류 처리
                    let alert = UIAlertController(title: "실패", message: "휴대폰 11자리를 정확히 입력해주세요.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(okAction)
                    present(alert, animated: false, completion: nil)
                }
            }
            else{
                //TODO: 2.에 대한 오류 처리
                let alert = UIAlertController(title: "실패", message: "주민번호를 명확히 입력해 주세요", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(okAction)
                present(alert, animated: false, completion: nil)
            }
        }
        else{//TODO: 1.에 대한 오류 처리
            let alert = UIAlertController(title: "실패", message: "주민번호 6자리를 명확히 입력해주세요.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(okAction)
            present(alert, animated: false, completion: nil)
        }
    }
    
    //UITextField가 수정이 시작되면 동작
    @objc func textFieldDidBeginEditing(_ sender: UITextField){
        print("textFieldDidBeginEditing: \((sender.text) ?? "Empty")")
    }
    
    //UITextField가 수정이 완료되면 동작
    @objc func textFieldDidEndEditing(_ sender: UITextField) {
        print("textFieldDidEndEditing: \((sender.text) ?? "Empty")")
    }
    
    
    //키보드에 완료버튼을 눌렀을 시 동작
    @objc func textFieldShouldReturn(_ sender: UITextField) -> Bool {
        print("textFieldShouldReturn \((sender.text) ?? "Empty")")
        
        codeText.resignFirstResponder()
        
        return true
    }
    
    
    
    @objc func touchColorChange(_ sender: UIButton){
        if sender == trainerButton{
            userButton.backgroundColor = .white
            trainerButton.backgroundColor = .purple
            classification = "trainer"
            UserDefaults.standard.removeObject(forKey: "classification")
            UserDefaults.standard.set(classification, forKey: "classification")
        }
        else if sender == userButton{
            trainerButton.backgroundColor = .white
            userButton.backgroundColor = .purple
            classification = "user"
            UserDefaults.standard.removeObject(forKey: "classification")
            UserDefaults.standard.set(classification, forKey: "classification")
        }
    }
    
    @objc private func touchUpLogoutButton(_ sender: UIButton) {
        do{
            try Auth.auth().signOut()
            loginInstance?.requestDeleteToken()
            print("logout successed")
            UserDefaults.standard.removeObject(forKey: "Uid")
            UserDefaults.standard.removeObject(forKey: "classification")
            UserDefaults.standard.removeObject(forKey: "LoginApi")
            UserApi.shared.logout {(error) in
                if let error = error {
                    print( error)
                }
                else{
                    print("kakao Logout Successed")
                }
            }
            
            
            
        }catch let signOutError as NSError{
            print("Error signing out: %@",signOutError)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        guard let text = textField.text else { return false }
        let maxLength = 1
        if text.count >= maxLength && range.length == 0 && range.location < maxLength {
            return false
        }
        return true
    }
    
}


extension ConstantMoreInfo{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("userid in ConstantMoreInfo ViewDidLoad \(FirebaseAuth.Auth.auth().currentUser?.uid)")
        
        view.backgroundColor = UIColor.white
        UserDefaults.standard.removeObject(forKey: "sex")
        UserDefaults.standard.set(9, forKey: "sex")
        UserDefaults.standard.removeObject(forKey: "position")
        //        UserDefaults.standard.set(position, forKey: "position")
        
        let headerview = HeaderView()
        
        let UserButtonSize = CGRect(x: 0, y: 0, width: 200, height: 30)
        trainerButton.frame = UserButtonSize
        userButton.frame = UserButtonSize
        
        let userbuttonstackview = UIStackView(arrangedSubviews: [trainerButton,userButton])
        userbuttonstackview.axis = .horizontal
        userbuttonstackview.spacing = 20
        userbuttonstackview.distribution = .fillEqually
        
        
        let usertypeStackView = UIStackView(arrangedSubviews: [UserTypeLabel,userbuttonstackview])
        usertypeStackView.axis = .horizontal
        usertypeStackView.spacing = 16
        usertypeStackView.distribution = .fill
        
        let birtdaybackstackview = UIStackView(arrangedSubviews: [Sexnum,endbirthdayConnection])
        birtdaybackstackview.axis = .horizontal
        birtdaybackstackview.distribution = .fill
        
        birthdayTextField.frame = UserButtonSize
        let birthdayfieldstackview = UIStackView(arrangedSubviews: [birthdayTextField,birtdaybackstackview])
        birthdayfieldstackview.axis = .horizontal
        birthdayfieldstackview.spacing = 20
        birthdayfieldstackview.distribution = .fillEqually
        
        let birthstackview = UIStackView(arrangedSubviews: [birthLabel,birthdayfieldstackview])
        birthstackview.axis = .horizontal
        birthstackview.spacing = 16
        birthstackview.distribution = .fill
        
        
        let phonestackview = UIStackView(arrangedSubviews: [phoneLabel,phoneText])
        phonestackview.spacing = 16
        phonestackview.axis = .horizontal
        phonestackview.distribution = .fill
        
        let fitnessconfirmstackview = UIStackView(arrangedSubviews: [codeText,fitnessCodeConfirmButton])
        fitnessconfirmstackview.axis = .horizontal
        fitnessconfirmstackview.spacing = 20
        fitnessconfirmstackview.distribution = .fillEqually
        
        let fitnesscodeview = UIStackView(arrangedSubviews: [codeLabel,fitnessconfirmstackview])
        fitnesscodeview.axis = .horizontal
        fitnesscodeview.spacing = 16
        fitnesscodeview.distribution = .fill
        
        [headerview,usertypeStackView,birthstackview,phonestackview,fitnesscodeview,mainPageButton,logoutButton].forEach{
            view.addSubview($0)
        }
        
        headerview.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        usertypeStackView.snp.makeConstraints{
            $0.top.equalTo(headerview.snp.bottom).offset(100)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        birthstackview.snp.makeConstraints{
            $0.top.equalTo(usertypeStackView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        phonestackview.snp.makeConstraints{
            $0.top.equalTo(birthstackview.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        fitnesscodeview.snp.makeConstraints{
            $0.top.equalTo(phonestackview.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        mainPageButton.snp.makeConstraints{
            $0.top.equalTo(fitnesscodeview.snp.bottom).offset(50)
            $0.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            $0.width.equalTo(200)
        }
        
        logoutButton.snp.makeConstraints{ (make) in
            make.bottom.equalTo(view.snp.bottom).inset(50)
            make.centerX.equalTo(self.view)
        }
    }
    
}
#if canImport(SwiftUI) && DEBUG
// MARK: - Preview for UIView
@available(iOS 13.0, *)
struct UIViewPreview<View: UIView>: UIViewRepresentable {
    let view: View
    init(_ builder: @escaping () -> View) {
        view = builder()
        
    }
    func makeUIView(context: Context) -> UIView {
        return view
        
    }
    func updateUIView(_ view: UIView, context: Context) {
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical) }
    
}

@available(iOS 13.0, *)
struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
    let viewController: ViewController
    init(_ builder: @escaping () -> ViewController) {
        viewController = builder()
        
    }
    func makeUIViewController(context: Context) -> ViewController {
        return viewController
        
    }
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        viewController.view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        viewController.view.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
}
#endif

struct ViewControlelrPreview:PreviewProvider{
    static var previews: some View{
        UIViewControllerPreview{
            let viewcontroller = ConstantMoreInfo()
            return viewcontroller
        }
    }
}
