# Uncomment the next line to define a global platform for your project
platform :ios, '9.3'

use_frameworks!

def shared_pods
    pod 'RxSwift'
    pod "Resolver"
end

target 'WildWest' do
  # Comment the next line if you don't want to use dynamic frameworks
#  inhibit_all_warnings!

  # Pods for WildWest
  shared_pods
  pod 'Firebase/Database'
  pod 'Firebase/Analytics'
  pod 'Firebase/Crashlytics'
  pod 'FirebaseUI/Auth'
  pod 'FirebaseUI/Google'
#  pod 'FirebaseUI/Facebook'
  pod 'FirebaseUI/OAuth' # Used for Sign in with Apple, Twitter, etc
  pod 'FirebaseUI/Phone'
  pod 'Kingfisher'
  pod 'SwiftLint'
end

target 'WildWestTests' do
  inherit! :search_paths
  # Pods for testing
  shared_pods
  pod 'Firebase/Database'
  pod 'Cuckoo'
end

target 'WildWestEngine' do
  # Pods for WildWestEngine
  shared_pods
end

target 'WildWestEngineTests' do
  # Pods for testing
  shared_pods
  pod 'Cuckoo'
  pod 'RxTest'
end
