# Uncomment the next line to define a global platform for your project
platform :ios, '9.3'

def shared_pods
  pod 'RxSwift'
  pod 'Firebase/Analytics'
  pod 'Firebase/Crashlytics'
  pod 'Firebase/Database'
end

target 'WildWest' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  shared_pods
  pod 'SwiftLint'
end

target 'WildWestTests' do
  inherit! :search_paths
  shared_pods
  pod 'RxBlocking'
  pod 'RxTest'
  pod 'Cuckoo'
end
