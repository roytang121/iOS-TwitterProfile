#
# Be sure to run `pod lib lint LFTwitterProfile.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LFTwitterProfile'
  s.version          = '0.1.0'
  s.summary          = 'Full-featured viewController which mimics Twitter Profile page.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

#   s.description      = <<-DESC
# TODO: Add long description of the pod here.
#                        DESC

  s.homepage         = 'https://github.com/roytang121/iOS-TwitterProfile'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Roy Tang' => 'me@roytang.me' }
  s.source           = { :git => 'https://github.com/roytang121/iOS-TwitterProfile.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/roytang121'

  s.ios.deployment_target = '9.0'

  s.source_files = 'LFTwitterProfile/Classes/**/*'

  s.resource_bundles = {
    'LFTwitterProfile' => ['LFTwitterProfile/Assets/*.png', 'LFTwitterProfile/Classes/**/*.xib']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'SnapKit', '~> 3.0'
end
