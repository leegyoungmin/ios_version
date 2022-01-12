//
//  AddUserView.swift
//  Salud0.2
//
//  Created by 이경민 on 2022/01/06.
//

import SwiftUI
import FirebaseDatabase
import FirebaseAuth
import Kingfisher

struct AddUserView:View{
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    @ObservedObject var traineruserlistViewModel = TrainerUserListViewModel()
    @GestureState private var dragOffset = CGSize.zero
    
    @State var inputPhoneNumber:String = ""
    @State var isShowCardView:Bool = false
    @State var isShowAlertView:Bool = false
    @State var isShowTrainerAlertView:Bool = false
    
    @State var newuserid:String = ""
    @State var newuserName:String = ""
    @State var newuserAge:String = ""
    @State var newuserGender:String = ""
    
    @State var ExistedTraiername:String = ""
    var body: some View{

        VStack{
            //검색화면 UI
            HStack{
                TextField("번호를 입력해주세요.", text: $inputPhoneNumber)
                    .textFieldStyle(.roundedBorder)

                Button {
                    traineruserlistViewModel.getNewUserid(inputPhoneNumber, completion: { newuser in
                        guard let userid = newuser.userid else{return}
                        if traineruserlistViewModel.useridList.contains(userid){
                            print(userid)
                            isShowAlertView = true
                        }
                        else{
                            newuserid = userid
                            newuserName = newuser.userName ?? ""
                            newuserAge = newuser.userAge ?? ""
                            newuserGender = newuser.userSex ?? "0"
                            isShowCardView = true
                        }
                    })
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                }
                .alert(isPresented: $isShowAlertView){
                    Alert(title: Text(""), message: Text("이미 추가한 회원입니다."), dismissButton: .default(Text("확인")))
                    
                }
            }
            //New User UI
            VStack(alignment:.center){
               Image("logo_only")
                    .frame(maxWidth:200, maxHeight:200)
                VStack(spacing:10){
                    Text("\(newuserName)")
                    Text("\(newuserAge) 년생")
                    Text("\(convertGender(gender:newuserGender))")
                }
                Button {
                    print("Button Clicked")
                    traineruserlistViewModel.AddUserid(newuserid, newuserName,completion: { trainerid in
                        traineruserlistViewModel.getExistedTrainer(trainerid, completion: { trainername in
                            ExistedTraiername = trainername
                            isShowTrainerAlertView = true
                        })
                    })
                } label: {
                    Text("추가하기")
                        .foregroundColor(.black)
                }
                .alert(isPresented: $isShowTrainerAlertView){
                    Alert(title: Text(""), message: Text("\(ExistedTraiername) 트레이너님 소속 회원입니다. 기존 트레이너에게 삭제를 요청해주세요."), dismissButton: .default(Text("확인")))
                }

            }
            .padding()
            .frame(width:UIScreen.main.bounds.width-50, alignment: .center)
            .background(Color.gray)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.vertical)
            .opacity(isShowCardView ? 1.0:0.0)
            
            Spacer()

        }
        .padding()
        .navigationTitle("회원 추가")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.purple)
                }

            }
        }

    }
    
    private func convertGender(gender:String)-> String{
        if gender == "0"{
            return "남성"
        }
        else{
            return "여성"
        }
    }
}

struct AddUserView_Previews:PreviewProvider{
    static var previews: some View{
        AddUserView()
    }
}
