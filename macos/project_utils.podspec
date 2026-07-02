#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint project_utils.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'project_utils'
  s.version          = '0.0.1'
  s.summary          = 'Flutter project utilities plugin.'
  s.description      = <<-DESC
Flutter project utilities with platform version API, Toast helpers, and KeepAlive wrapper.
                       DESC
  s.homepage         = 'https://github.com/xyf1326131920-collab/project_utils'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'XiuYunFei' => 'https://github.com/xyf1326131920-collab' }

  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'FlutterMacOS'

  s.platform = :osx, '10.11'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
