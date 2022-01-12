# Uncomment the next line to define a global platform for your project

platform :ios, '14.0'
use_frameworks!
target 'Salud0.2' do
  # Comment the next line if you don't want to use dynamic frameworks
#use_modular_headers!
  # Pods for Salud0.2
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings["ONLY_ACTIVE_ARCH"]="NO"
      end
    end
  end
  
pod 'KakaoSDK'
pod 'naveridlogin-sdk-ios'
pod 'Alamofire','~>5.3'
pod 'SnapKit'
pod 'Charts'
pod 'ToastUI'

#Firebase
pod 'Firebase/Core'
pod 'Firebase/Database'
pod 'Firebase/Analytics'
pod 'Firebase/Firestore'
pod 'Firebase/Auth'
pod 'Firebase/Storage'
pod 'Firebase/Functions'

#Google Login
pod 'GoogleSignIn'


#Message
pod 'MessageKit'

#Kingfisher
pod 'Kingfisher'

#Image
pod 'SDWebImage'

#ObjectMapper
pod 'ObjectMapper'

end
