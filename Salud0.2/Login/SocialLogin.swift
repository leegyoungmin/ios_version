//
//  SocialLogin.swift
//  Salud0.2
//
//  Created by 이관형 on 2021/10/15.
//


import SwiftUI
import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import NaverThirdPartyLogin
import Alamofire
import FirebaseAuth
import FirebaseDatabase
import FirebaseFunctions
import Firebase
import GoogleSignIn
import AuthenticationServices
import SnapKit
import CryptoKit

class SocialLogin: UIViewController, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
    var functions = Functions.functions();
    
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    var isOnCheck: Bool?
    var currentNonce: String?
    
    private let logoImage: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "ProductLogo")
        return logo
    }()
    
    
    //카카오 로그인 버튼 선언
    private let kakaoLoginButton: UIButton = {
        let kakaoButton = UIButton()
        kakaoButton.setImage(UIImage(named: "kakaologo"), for: .normal)
        kakaoButton.setTitle("카카오로 시작하기", for: .normal)
        kakaoButton.setTitleColor(.black, for: .normal)
        kakaoButton.backgroundColor = .yellow
        kakaoButton.layer.cornerRadius = 10
        kakaoButton.layer.shadowColor = UIColor.lightGray.cgColor
        kakaoButton.layer.shadowOpacity = 1.0
        kakaoButton.layer.shadowRadius = 2
        kakaoButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        kakaoButton.marginImageWithText(margin: 50)
        kakaoButton.addTarget(self, action: #selector(touchUpKakaoLogin(_:)), for: .touchUpInside)
        
        return kakaoButton
    }()
    
    //네이버 로그인 버튼 선언
    private let naverLoginButton: UIButton = {
        let naverButton = UIButton()
        naverButton.setImage(UIImage(named: "naverlogin"), for: .normal)
        naverButton.setTitle("네이버로 시작하기", for: .normal)
        naverButton.setTitleColor(.black, for: .normal)
        naverButton.backgroundColor = UIColor(named: "NaverColor")
        naverButton.layer.cornerRadius = 10
        naverButton.layer.shadowColor = UIColor.lightGray.cgColor
        naverButton.layer.shadowOpacity = 1.0
        naverButton.layer.shadowRadius = 2
        naverButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        naverButton.marginImageWithText(margin: 50)
        naverButton.addTarget(self, action: #selector(touchUpNaverLogin(_:)), for: .touchUpInside)
        
        return naverButton
    }()
    //구글 로그인 버튼 선언
    private let googleLoginButton: UIButton = {
        let googlebutton = UIButton()
        googlebutton.setImage(UIImage(named: "googleImage"), for: .normal)
        googlebutton.setTitle("구글로 시작하기", for: .normal)
        googlebutton.setTitleColor(.black, for: .normal)
        googlebutton.backgroundColor = UIColor.white
        googlebutton.layer.cornerRadius = 10
        googlebutton.layer.shadowColor = UIColor.lightGray.cgColor
        googlebutton.layer.shadowOpacity = 1.0
        googlebutton.layer.shadowRadius = 2
        googlebutton.layer.shadowOffset = CGSize(width: 1, height: 1)
        googlebutton.marginImageWithText(margin: 52)
        googlebutton.addTarget(self, action: #selector(touchUpGoogleLogin(_:)), for: .touchUpInside)
        
        return googlebutton
    }()
    
    //애플 로그인 버튼 선언
    @available(iOS 13.0, *)
    private let appleLoginButton: UIButton = {
        let apple = UIButton()
        apple.setTitle("애플로 시작하기", for: .normal)
        apple.setImage(UIImage(named: "appleLogo"), for: .normal)
        apple.backgroundColor = .black
        apple.marginImageWithText(margin: 50)
        apple.layer.cornerRadius = 10
        apple.layer.shadowColor = UIColor.lightGray.cgColor
        apple.layer.shadowOpacity = 1.0
        apple.layer.shadowRadius = 2
        apple.layer.shadowOffset = CGSize(width: 1, height: 1)
        apple.addTarget(self, action: #selector(appleSignInButtonPress), for: .touchUpInside)
        return apple
    }()
    
    
    
    
    @objc private func touchUpKakaoLogin(_ sender: UIButton){
        //Kakao로그인 함수 호출하여 Token 값 가져오기
        
        let ispossible = UserApi.isKakaoTalkLoginAvailable()
        
        if AuthApi.hasToken(){
            KakaoLogin(ispossible: ispossible)
        }
        else{
            print("View Did Load not has Token")
        }
        
        if AuthApi.hasToken(){
            KakaoLogin(ispossible: ispossible)
        }
        else{
            KakaoLogin(ispossible: ispossible)
        }
        
    }
    
    @objc private func touchUpNaverLogin(_ sender: UIButton) {
        loginInstance?.delegate = self
        loginInstance?.requestThirdPartyLogin()
        //TODO: 로그인시 1. 이미 로그인 되었을때 2. 처음 로그인을 했을때
    }
    
    
    //토큰 값을 통해서 커스텀 토큰 발행 함수 호출
    private func KakaoLogin(ispossible:Bool){
        if ispossible{
            UserApi.shared.loginWithKakaoTalk(){oauthToken,error in
                guard error == nil else{return}
                
                guard let oauthToken = oauthToken?.accessToken else{return}
                self.kakaoCustomTokenLogin(oauthToken: oauthToken)
            }
        }
        else{
            UserApi.shared.loginWithKakaoAccount(){oauthToken,error in
                guard let oauthToken = oauthToken?.accessToken else{return}
                self.kakaoCustomTokenLogin(oauthToken: oauthToken)
            }
        }
    }
    
    @available(iOS 13.0, *)
    @objc private func appleSignInButtonPress(_ sender: UIButton){
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
        startSignInWithAppleFlow()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        
        let apitype = UserDefaults.standard.string(forKey: "LoginApi")
        print("apitype in SocialLogin \(apitype)")
        switch apitype{
        case "kakao":
            touchUpKakaoLogin(kakaoLoginButton)
        case "naver":
            touchUpNaverLogin(naverLoginButton)
        case "Google":
            touchUpGoogleLogin(googleLoginButton)
        case .none:
            return
        case .some(_):
            return
        }
        
    }
    
}

private extension SocialLogin{
    func setupLayout() {
        let guide = view.safeAreaLayoutGuide
        
        [
            logoImage,
            kakaoLoginButton,
            naverLoginButton,
            googleLoginButton,
            appleLoginButton
        ].forEach{
            view.addSubview($0)
        }
        
        logoImage.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(200)
            $0.width.equalTo(200)
        }
        
        kakaoLoginButton.snp.makeConstraints{
            $0.top.equalTo(logoImage.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(50)
            $0.trailing.equalToSuperview().offset(-50)
            $0.height.equalTo(50)
        }
        naverLoginButton.snp.makeConstraints{
            $0.top.equalTo(kakaoLoginButton.snp.bottom).offset(10)
            $0.leading.equalTo(kakaoLoginButton.snp.leading)
            $0.trailing.equalTo(kakaoLoginButton.snp.trailing)
            $0.height.equalTo(50)
        }
        
        googleLoginButton.snp.makeConstraints{
            $0.top.equalTo(naverLoginButton.snp.bottom).offset(10)
            $0.leading.equalTo(naverLoginButton.snp.leading)
            $0.trailing.equalTo(naverLoginButton.snp.trailing)
            $0.height.equalTo(50)
        }
        
        appleLoginButton.snp.makeConstraints{
            $0.top.equalTo(googleLoginButton.snp.bottom).offset(10)
            $0.leading.equalTo(googleLoginButton.snp.leading)
            $0.trailing.equalTo(googleLoginButton.snp.trailing)
            $0.height.equalTo(50)
        }
        
    }
    
    //Kakao Login Start Functions With Cloud Functions
    private func kakaoCustomTokenLogin(oauthToken:String){
        self.functions.httpsCallable("kakaoToken").call(["access_token":oauthToken]){
            result,error in
            guard error == nil else{return}
            
            guard let customtoken = result?.data as? String else{return}
            FirebaseAuth.Auth.auth().signIn(withCustomToken: customtoken){result,error in
                if error == nil{
                    
                    //새로운 유저인지 판단 하기
                    guard let isnewuser = result?.additionalUserInfo?.isNewUser else{return}
                    //새로운 유저일 경우 ConstantMoreInfo Present
                    if isnewuser{
                        let vc = ConstantMoreInfo()
                        vc.modalPresentationStyle = .fullScreen
                        UserDefaults.standard.set("kakao", forKey: "LoginApi")
                        self.present(vc,animated: true)
                    }
                    //새로운 유저가 아닐 경우 UserType을 확인함.
                    else{
                        guard let uid = result?.user.uid else{return}
                        Firebase.Database.database().reference()
                            .child("Trainer").observe(.value){snapshot in
                                if snapshot.hasChild(uid){
                                    //userType이 트레이너일 경우
                                    let vc = UIHostingController(rootView: TrainerBaseView())
                                    vc.modalPresentationStyle = .fullScreen
                                    UserDefaults.standard.set("naver", forKey: "LoginApi")
                                    self.present(vc, animated: true)
                                }
                                else{
                                    //userType이 회원일 경우
                                    let vc = UIHostingController(rootView: UserBaseView().environmentObject(UserBaseViewModel()))
                                    vc.modalPresentationStyle = .fullScreen
                                    UserDefaults.standard.set("naver", forKey: "LoginApi")
                                    self.present(vc, animated: true)
                                }
                                
                            }
                    }
                
                }
                else{
                    print(error?.localizedDescription)
                }
            }
        }
        
    }
    //Naver Login Start Functions With Cloud Functions
    func getNaverInfo() {
        // 현재 토큰이 유효한지 확인 > default로 1시간
        //TODO: 파이어베이스와 연동하여 커스텀 토큰 생성
        
        guard let isValidAccessToken = loginInstance?.isValidAccessTokenExpireTimeNow() else { return }
        
        if !isValidAccessToken {
            return
        }
        
        
        guard let tokenType = loginInstance?.tokenType else { return }
        guard let accessToken = loginInstance?.accessToken else { return }
        
        //TODO: 1. 네이버의 accessToken을 별도의 서버로 넘겨서 Firebase Admin SDK를 이용해 JWt 형태의 Custom Token 을 받아야 한다.
        
        //이메일: 카카오 토큰의 이메일 //패스워드: 카카오 토큰의 id ==>Firebase의 uid 와 같은 역할
        //==> 네이버 토큰 : accessToken, 패스워드 : id
        
        //다음과 같은 상황을 네이버 내에서 구현하면 성공
        
        let urlStr = "https://openapi.naver.com/v1/nid/me"
        let url = URL(string: urlStr)!
        let authorization = "\(tokenType) \(accessToken)"
        let req = AF.request(url, method: .get, parameters: nil,
                             encoding: JSONEncoding.default, headers: ["Authorization": authorization])
        req.responseJSON {(response) in
            
            
            guard let result = response.value as? [String: Any] else { return }
            guard let object = result["response"] as? [String: Any] else { return }
            let name = object["name"] as? String
            let email = object["email"] as? String
            let id = object["id"] as? String
            let birth = object["birthday"] as? String
            let gender = object["gender"] as? String
            let _ = object["age"] as? String
            //            let birthyear = object["birthyear"] as? String
            //            let phonenum = object["mobile"] as? String
            //TODO: CloudFunction Login
            self.functions.httpsCallable("NaverToken").call([
                "access_token":accessToken,
                "userid":id,
                "name":name,
                "email":email
            ]){
                result,error in
                guard error == nil else {
                    return
                }
                guard let customtoken = result?.data as? String else{return}
                
                FirebaseAuth.Auth.auth().signIn(withCustomToken: customtoken){
                    result,error in
                    if error == nil{
                        guard let isnewuser = result?.additionalUserInfo?.isNewUser else{return}
                        
                        if(isnewuser){
                            let vc = ConstantMoreInfo()
                            vc.modalPresentationStyle = .fullScreen
                            UserDefaults.standard.set("naver", forKey: "LoginApi")
                            self.present(vc, animated: true)
                        }
                        else{
                            guard let uid = result?.user.uid else{return}
                            Firebase.Database.database().reference()
                                .child("Trainer").observe(.value){snapshot in
                                    if snapshot.hasChild(uid){
                                        let vc = UIHostingController(rootView: TrainerBaseView())
                                        vc.modalPresentationStyle = .fullScreen
                                        UserDefaults.standard.set("naver", forKey: "LoginApi")
                                        self.present(vc, animated: true)
                                    }
                                    else{
                                        let vc = UIHostingController(rootView: UserBaseView().environmentObject(UserBaseViewModel()))
                                        vc.modalPresentationStyle = .fullScreen
                                        UserDefaults.standard.set("naver", forKey: "LoginApi")
                                        self.present(vc, animated: true)
                                    }
                                    
                                }
                        }
                        
                        
                        

                    }
                }
            }
            
        }
        
        print("Finished")
    }
    //Google Login Start Functions With Firebase Credential
    @objc private func touchUpGoogleLogin(_ sender: UIButton){
        //        GIDSignIn.sharedInstance()?.signIn()
        guard let cliendID = FirebaseApp.app()?.options.clientID else { return }
        let signInConfig = GIDConfiguration.init(clientID: cliendID)
        
        //1. 파이어베이스의 인증 정보를 가져온다.
        //2. 구글 로그인을 시도하기 위해 셋팅해준다.
        //3. 구글 로그인을 시도하는데, 시도 결과에 따라 각각 처리한다.
        //3.1 실패 시 return
        //3.2 성공 시 구글 로그인 정보(access token)을 가져와, 파이어베이스에 로그인을 시도한다.
        
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self){user, error in
            guard error == nil else { return }
            
            guard let authentication = user?.authentication else { return }
            guard let user = user else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken! , accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential){_,_ in
                if let error = error{
                    print("Firebase With Google SignUP:  failed")
                    print(error)
                }else{
                    print("Firebase With Google SignUP: Success")
                    //로그인 정보 가져오기
                    let email = user.profile?.email
                    let fullName = user.profile?.name
                    //                    let familyName = user.profile?.familyName
                    //                    let givenName = user.profile?.givenName
                    let _ = user.profile?.imageURL(withDimension: 320)
                    let _ = user.profile
                    let uid = Auth.auth().currentUser?.uid
                    //로그인 페이지 넘어서 기본정보 드갈때
                    let vc = ConstantMoreInfo()
                    UserDefaults.standard.set(email, forKey: "email")
                    UserDefaults.standard.set(fullName, forKey: "name")
                    UserDefaults.standard.set(uid, forKey: "Uid")
                    UserDefaults.standard.set("Google", forKey: "LoginApi")
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true)
                }
            }
        }
    }
    //apple Login Start Functions
    func startSignInWithAppleFlow() {
        let nonce = randomNonceString()
        
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        // request 요청을 했을 때 none가 포함되어서 릴레이 공격을 방지
        // 추후 파베에서도 무결성 확인을 할 수 있게끔 함
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
        
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
}


extension SocialLogin: NaverThirdPartyLoginConnectionDelegate{
    
    //로그인에 성공했을 경우 호출
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("Success login")
        getNaverInfo()
        
        //로그인 성공시 MainViewController로 페이지 Transition
        //근거: 로그인 성공시 파이어베이스에 저장되는 것 확인.
        let vc = ConstantMoreInfo()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    }
    
    
    //접근 토큰 갱신
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        loginInstance?.resetToken()
        //        loginInstance?.accessToken
    }
    
    //로그아웃 할 경우 호출(토큰 삭제)
    func oauth20ConnectionDidFinishDeleteToken() {
        //        print("log out")
        loginInstance?.requestDeleteToken()
        print("logoutted")
        
    }
    
    
    //모든 에러 호출
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("error = \(error.localizedDescription)")
    }
}

@available(iOS 13.0, *)
extension SocialLogin: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            // Initialize a Firebase credential.
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            // Sign in with Firebase.
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if (error != nil) {
                    print(error!.localizedDescription)
                    return
                }
            }
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            let uid = Auth.auth().currentUser?.uid
            
            print("User ID : \(userIdentifier)")
            print("User Email : \(email ?? "")")
            print("User Name : \((fullName?.givenName ?? "") + (fullName?.familyName ?? ""))")
            
            let full = (fullName?.givenName ?? "") + (fullName?.familyName ?? "")
            
            let vc = ConstantMoreInfo()
            UserDefaults.standard.set(email, forKey: "email")
            UserDefaults.standard.set(full, forKey: "name")
            UserDefaults.standard.set(uid, forKey: "Uid")
            UserDefaults.standard.set("Apple", forKey: "LoginApi")
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
            
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        print("Sign in with Apple errored: \(error)")
    }
    
}

extension UIButton{
    func marginImageWithText(margin:CGFloat){
        let halfSize = margin/2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -halfSize, bottom: 0, right: halfSize)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: halfSize, bottom: 0, right: -halfSize)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: halfSize, bottom: 0, right: halfSize)
    }
}


struct SocialLoginPreivew:PreviewProvider{
    static var previews: some View{
        UIViewControllerPreview{
            let viewcontroller = SocialLogin()
            return viewcontroller
        }
    }
}
