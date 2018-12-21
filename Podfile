# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'MedicoBox' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MedicoBox

    pod 'GoogleSignIn'
    pod 'Google/SignIn'
    pod 'Firebase/Auth'
    pod 'Firebase/Core'
    pod 'Alamofire', '~> 4.4'
    pod 'SVProgressHUD'
    pod 'SDWebImage', '~>3.8'
    pod 'Fabric'
    pod 'Crashlytics'
    pod 'SwiftyJSON'
    pod 'GoogleMaps'
    pod 'GooglePlaces'
    pod 'FSPagerView'
    pod 'IQKeyboardManager'
    pod 'OpalImagePicker'
end

swift4 = ['OpalImagePicker']

post_install do |installer|
    installer.pods_project.targets.each do |target|
        swift_version = nil
        
        if swift4.include?(target.name)
            swift_version = '4.2'
        end
        
        if swift_version
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = swift_version
            end
        end
    end
end
