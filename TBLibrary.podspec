#
# Be sure to run `pod lib lint TBLibrary.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TBLibrary'
  s.version          = '0.0.2'
  s.summary          = 'TBLibrary.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                        this project provide all kinds of kits for iOS developer
                       DESC

  s.homepage         = 'https://github.com/yyakun/TBLibrary'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'yyakun' => '296789695@qq.com' }
  s.source           = { :git => 'https://github.com/yyakun/TBLibrary.git', :tag => '0.0.2'}
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'TBLibrary/Classes/**/*'
  
  # s.resource_bundles = {
  #   'TBLibrary' => ['TBLibrary/Assets/*.png']
  # }
   s.requires_arc = true
   s.dependency "AFNetworking"
   s.dependency "MBProgressHUD"
   s.dependency "GTMBase64"
   s.dependency "FMDB"
end
