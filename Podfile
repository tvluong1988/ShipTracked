source 'https://github.com/CocoaPods/Specs.git'
platform :ios, "9.1"

use_frameworks!

def testing_pods
  pod 'Quick'
  pod 'Nimble'
end

target 'ShipTracked' do
  pod 'SwiftyJSON'
  pod 'GoogleMaps'
  
  target 'ShipTrackedTests' do
    inherit! :search_paths
    testing_pods
  end
end


