Pod::Spec.new do |s|
  s.name             = 'SwiftLocationManager'
  s.version          = '0.1.1'
  s.summary          = 'CLLocationManager wrapper, provides functions such as getting location, reverse geocoding using apple service.'
  s.homepage         = 'https://github.com/thanhpn91/SwiftLocationManager.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Thanh Pham' => 'thanh.pham@siclo-mobile.com' }
  s.source           = { :git => 'https://github.com/thanhpn91/SwiftLocationManager.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'SwiftLocationManager/Classes/**/*'
end
