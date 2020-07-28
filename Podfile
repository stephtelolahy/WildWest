# Uncomment the next line to define a global platform for your project
platform :ios, '9.3'

inhibit_all_warnings!

def shared_pods
  pod 'RxSwift'
  pod 'Firebase/Database'
end

target 'WildWest' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  shared_pods
  
  pod 'Firebase/Analytics'
  pod 'Firebase/Crashlytics'
  pod 'FirebaseUI/Auth'
  pod 'FirebaseUI/Google'
  pod 'FirebaseUI/Facebook'
  pod 'FirebaseUI/OAuth' # Used for Sign in with Apple, Twitter, etc
  pod 'FirebaseUI/Phone'
  
  pod 'Kingfisher'
  
  pod 'SwiftLint'
end

target 'WildWestTests' do
  inherit! :search_paths
  shared_pods
  pod 'RxBlocking'
  pod 'RxTest'
  pod 'Cuckoo'
end
