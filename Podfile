# Uncomment the next line to define a global platform for your project
platform :ios, '9.3'

inhibit_all_warnings!

def shared_pods
  pod 'CardGameEngine', :git => 'git@bitbucket.org:stephanotelolahy/cardgameengine.git', :branch => 'develop'
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
  
  pod "Resolver"
  pod 'Kingfisher'
  pod 'SwiftLint'
end

target 'WildWestTests' do
  inherit! :search_paths
  shared_pods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ONLY_ACTIVE_ARCH'] = 'YES'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.3'
    end
  end
end
