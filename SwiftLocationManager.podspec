Pod::Spec.new do |s|
  s.name             = 'SwiftLocationManager'
  s.version          = '0.1.0'
  s.summary          = 'CLLocationManager wrapper, provides functions such as getting location, reverse geocoding using apple service.'
  s.description      = <<-DESC DESC
  s.homepage         = 'https://github.com/<GITHUB_USERNAME>/SwiftLocationManager'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Thanh Pham' => 'thanh.pham@siclo-mobile.com' }
  s.source           = { :git => 'https://github.com/thanhpn91/SwiftLocationManager.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.ios.deployment_target = '8.0'
  s.source_files = 'SwiftLocationManager/Classes/**/*'
end
