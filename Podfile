project 'Championes Arena.xcodeproj'
  use_frameworks!

# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Championes Arena' do

  # Pods for Championes Arena
  
  #pod 'M13Checkbox'
  #pod 'SwiftLint', '~> 0.27'
  
  pod 'PopupDialog'
  pod 'IQKeyboardManagerSwift'
  pod 'Alamofire'
  pod 'SwiftyJSON'
  pod 'Kingfisher'
  pod 'NewPopMenu'
  pod 'OneSignal', '>= 2.6.2', '< 3.0'
  #pod 'FacebookCore'
  #pod 'FacebookLogin'
  #pod 'FacebookShare'
  
end

target 'OneSignalNotifications' do
  pod 'OneSignal', '>= 2.6.2', '< 3.0'
end
  
  
  
  
  
  
  
  
  
  
  
  
#########################################
#########################################  
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['CLANG_WARN_DOCUMENTATION_COMMENTS'] = 'NO'
        end
    end
end