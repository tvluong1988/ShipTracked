source 'https://github.com/CocoaPods/Specs.git'
platform :ios, "9.1"

use_frameworks!

def testing_pods
  pod 'Quick'
  pod 'Nimble'
end

target 'ShipTracked' do
  pod 'SwiftyJSON'
  
  target 'ShipTrackedTests' do
    inherit! :search_paths
    testing_pods
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
