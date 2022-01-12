//
//  UserMoreInfo.swift
//  Salud0.2
//
//  Created by 이관형 on 2021/11/03.
//
import Foundation
import SwiftUI
import SnapKit
import FirebaseAuth
import FirebaseDatabase



class UserMoreInfo: UIViewController {
    let okAction = UIAlertAction(title: "OK", style: .default){ (action) in }
    let uid = Auth.auth().currentUser?.uid
    let ref = Database.database().reference()
    
    private let headerview = HeaderView()
    
    
    private let heightLabel: UILabel = {
        let height = UILabel()
        height.text = "키"
        height.textColor = UIColor.purple
        height.font = .systemFont(ofSize: 20, weight: .semibold)
        height.textAlignment = .center
        return height
    }()
    
    private let heightText: UITextField = {
        let height = UITextField()
        height.borderStyle = .roundedRect
        height.placeholder = ""
        height.adjustsFontSizeToFitWidth = true
        height.addTarget(self, action: #selector(textFieldShouldReturn(_:)), for: .editingDidEndOnExit)
        height.keyboardType = .numbersAndPunctuation
        return height
    }()
    
    private let heightunitlabel : UILabel = {
        let heightunitlabel = UILabel()
        heightunitlabel.text = "cm"
        heightunitlabel.textColor = .black
        heightunitlabel.font = .systemFont(ofSize: 20, weight: .medium)
        return heightunitlabel
    }()
    
    
    private let weightLabel: UILabel = {
        let weight = UILabel()
        weight.text = "몸무게"
        weight.textColor = UIColor.purple
        weight.font = .systemFont(ofSize: 20, weight: .semibold)
        weight.textAlignment = .center
        return weight
    }()
    
    private let weightText: UITextField = {
        let weight = UITextField()
        weight.borderStyle = .roundedRect
        weight.placeholder  = ""
        weight.addTarget(self, action: #selector(textFieldShouldReturn(_:)), for: .editingDidEndOnExit)
        return weight
    }()
    
    private let weightunitlabel : UILabel = {
        let weightunitlabel = UILabel()
        weightunitlabel.text = "kg"
        weightunitlabel.textColor = .black
        weightunitlabel.font = .systemFont(ofSize: 20, weight: .medium)
        return weightunitlabel
    }()
    
    private let fatLabel: UILabel = {
        let fat = UILabel()
        fat.text = "체지방량"
        fat.textColor = UIColor.purple
        fat.font = .systemFont(ofSize: 20, weight: .semibold)
        fat.textAlignment = .center
        return fat
    }()
    
    private let fatText: UITextField = {
        let fat = UITextField()
        fat.borderStyle = .roundedRect
        fat.placeholder = ""
        fat.addTarget(self, action: #selector(textFieldShouldReturn(_:)), for: .editingDidEndOnExit)
        fat.keyboardType = .numbersAndPunctuation
        return fat
    }()
    
    private let fatunitlabel : UILabel = {
        let fatunitlabel = UILabel()
        fatunitlabel.text = "%"
        fatunitlabel.textColor = .black
        fatunitlabel.font = .systemFont(ofSize: 20, weight: .medium)
        return fatunitlabel
    }()
    
    private let muscleLabel: UILabel = {
        let muscle = UILabel()
        muscle.text = "근육량"
        muscle.textColor = UIColor.purple
        muscle.font = .systemFont(ofSize: 20, weight: .semibold)
        muscle.textAlignment = .center
        return muscle
    }()
    
    private let muscleText: UITextField = {
        let muscle = UITextField()
        muscle.borderStyle = .roundedRect
        muscle.placeholder = ""
        muscle.addTarget(self, action: #selector(textFieldShouldReturn(_:)), for: .editingDidEndOnExit)
        muscle.keyboardType = .numbersAndPunctuation
        return muscle
    }()
    
    private let muscleunitlabel : UILabel = {
        let muscleunitlabel = UILabel()
        muscleunitlabel.text = "kg"
        muscleunitlabel.textColor = .black
        muscleunitlabel.font = .systemFont(ofSize: 20, weight: .medium)
        return muscleunitlabel
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = false
        
        let userEditTextSize = CGRect(x: 0, y: 0, width: 200, height: 30)
        [heightLabel,weightText,fatText,muscleText].forEach{
            $0.frame = userEditTextSize
        }
        
        let heightstackview = UIStackView(arrangedSubviews: [heightLabel,heightText,heightunitlabel])
        heightstackview.axis = .horizontal
        heightstackview.spacing = 10
        heightstackview.distribution = .fillEqually
        
        let weightstackview = UIStackView(arrangedSubviews: [weightLabel,weightText,weightunitlabel])
        weightstackview.axis = .horizontal
        weightstackview.spacing = 10
        weightstackview.distribution = .fillEqually
        
        let fatstackview = UIStackView(arrangedSubviews: [fatLabel,fatText,fatunitlabel])
        fatstackview.axis = .horizontal
        fatstackview.spacing = 10
        fatstackview.distribution = .fillEqually
        
        let musclestackview = UIStackView(arrangedSubviews: [muscleLabel,muscleText,muscleunitlabel])
        musclestackview.axis = .horizontal
        musclestackview.spacing = 10
        musclestackview.distribution = .fillEqually
        
        [
            headerview,
            heightstackview,
            weightstackview,
            fatstackview,
            musclestackview,
            mainPageButton
        ].forEach{
            view.addSubview($0)
        }
        
        headerview.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        heightstackview.snp.makeConstraints{
            $0.top.equalTo(headerview.snp.bottom).offset(100)
            $0.leading.trailing.equalToSuperview()
        }
        weightstackview.snp.makeConstraints{
            $0.top.equalTo(heightstackview.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
        }
        
        fatstackview.snp.makeConstraints{
            $0.top.equalTo(weightstackview.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
        }
        musclestackview.snp.makeConstraints{
            $0.top.equalTo(fatstackview.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
        }
        mainPageButton.snp.makeConstraints{
            $0.top.equalTo(musclestackview.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(100)
            $0.trailing.equalToSuperview().offset(-100)
        }
        
        
    }
    
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
//        codeText.resignFirstResponder()
        return true
    }
    
    @objc func nextPage(_ sender: UIButton){
        print("Clicked nextPage")
        let navigationController = UINavigationController(rootViewController: UIHostingController(rootView: UserBaseView()))
        navigationController.modalPresentationStyle = .fullScreen
        let height: String = heightText.text ?? "default"
        let weight: String = weightText.text ?? "default"
        let muscle: String = muscleText.text ?? "default"
        let fat: String = fatText.text ?? "default"
        
        let doubleHeight: Double = Double(height) ?? 0.0
        let doubleWeight: Double = Double(weight) ?? 0.0
        let doubleMuscle: Double = Double(muscle) ?? 0.0
        let doubleFat: Double = Double(fat) ?? 0.0
        var userInfo = [String: String]()
        if doubleHeight < 210.0 && doubleHeight > 50.0{
            if doubleWeight < 150.0 && doubleWeight > 30.0{
                if doubleMuscle != 0.0 && doubleFat == 0.0{
                    userInfo.removeAll()
                    userInfo["height"] = String(doubleHeight)
                    userInfo["weight"] = String(doubleWeight)
                    userInfo["fat"] = "default"
                    userInfo["muscle"] = String(doubleMuscle)
                    userInfo["kcalSetting"] = "0"
                    ref.child("UserInfo").child(uid!).setValue(userInfo)
                    let vc = UIHostingController(rootView: UserBaseView().navigationBarHidden(true))
                    DispatchQueue.main.async {
                        vc.navigationController?.isNavigationBarHidden = true
                    }
                    vc.modalPresentationStyle = .fullScreen
                    present(navigationController,animated: true)
                    
//                        .fullScreenCover(isPresented: $loggedIn, content: UserTableView.init)
//                        .buttonStyle(.plain)
                    
                }else if doubleMuscle == 0.0 && doubleFat == 0.0{
                    userInfo.removeAll()
                    userInfo["height"] = String(doubleHeight)
                    userInfo["weight"] = String(doubleWeight)
                    userInfo["fat"] = String(doubleFat)
                    userInfo["muscle"] = "default"
                    userInfo["kcalSetting"] = "0"
                    ref.child("UserInfo").child(uid!).setValue(userInfo)
                    let vc = UIHostingController(rootView: UserBaseView().navigationBarHidden(true))
                    vc.modalPresentationStyle = .fullScreen
                    present(navigationController,animated: true)
                    
                }else if doubleMuscle == 0.0 && doubleFat != 0.0{
                    userInfo.removeAll()
                    userInfo["height"] = String(doubleHeight)
                    userInfo["weight"] = String(doubleWeight)
                    userInfo["fat"] = "default"
                    userInfo["muscle"] = "default"
                    userInfo["kcalSetting"] = "0"
                    ref.child("UserInfo").child(uid!).setValue(userInfo)
                    let vc = UIHostingController(rootView: UserBaseView().navigationBarHidden(true))
                    DispatchQueue.main.async {
                        vc.navigationController?.isNavigationBarHidden = true
                    }

                    vc.modalPresentationStyle = .fullScreen
                    present(navigationController,animated: true)
                    
                }else if doubleMuscle != 0.0 && doubleFat != 0.0{
                    userInfo.removeAll()
                    userInfo["height"] = String(doubleHeight)
                    userInfo["weight"] = String(doubleWeight)
                    userInfo["fat"] = String(doubleFat)
                    userInfo["muscle"] = String(doubleMuscle)
                    userInfo["kcalSetting"] = "0"
                    ref.child("UserInfo").child(uid!).setValue(userInfo)
                    let vc = UIHostingController(rootView: UserBaseView().navigationBarHidden(true))
                    DispatchQueue.main.async {
                        vc.navigationController?.isNavigationBarHidden = true
                    }
                    vc.modalPresentationStyle = .fullScreen
                    present(navigationController,animated: true)
                }
            }else{
                let alert = UIAlertController(title: "실패", message: "몸무게를 정확히 입력해주세요.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(okAction)
                present(alert, animated: false, completion: nil)
            }
        }else{
            let alert = UIAlertController(title: "실패", message: "키를 정확히 입력해주세요.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(okAction)
            present(alert, animated: false, completion: nil)
        }
        
        
    }
    
}


struct UserMoreInfoPreview:PreviewProvider{
    static var previews: some View{
        UIViewControllerPreview{
            let controller = UserMoreInfo()
            return controller
        }
    }
}
