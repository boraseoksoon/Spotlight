#
# Be sure to run `pod lib lint Spotlight.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Spotlight'
  s.version          = '0.1.1'
  s.summary          = 'Spotlight UI written in SwiftUI and Combine'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = "Spotlight UI written in SwiftUI and Combine"

  s.homepage         = 'https://github.com/boraseoksoon/Spotlight'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'boraseoksoon' => 'boraseoksoon@gmail.com' }
  s.source           = { :git => 'https://github.com/boraseoksoon/Spotlight.git', :tag => s.version.to_s }

  s.social_media_url = 'https://twitter.com/boraseoksoon'
  s.swift_version = '5.1'
  s.ios.deployment_target = '13.0'
  s.source_files = 'Spotlight/Classes/**/*'
  s.frameworks = 'UIKit', 'Foundation', 'SwiftUI', 'Combine'
end


