# Uncomment the next line to define a global platform for your project

target 'WildWest' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!

  # Pods for WildWest
  pod 'RxSwift'
  pod 'Firebase/Database'
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

  target 'WildWestTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

target 'WildWestEngine' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for WildWestEngine
  pod 'RxSwift'
  pod "Resolver"

  target 'WildWestEngineTests' do
    # Pods for testing
    pod 'Cuckoo'
    pod 'RxTest'
  end

end
