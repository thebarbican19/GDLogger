#
#  Be sure to run `pod spec lint GDLogger.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "GDLogger"
  s.version      = "1.1"
  s.summary      = "GDLogger is a lightweight class for iOS versions 3.0 and above. It allows developers to log in app 'events' locally"  
  s.description  = "GDLogger is a lightweight class for iOS versions 3.0 and above. It allows developers to log in app 'events' locally in mutilple, mutable txt files."
  s.homepage     = "https://github.com/northernspark/GDLogger"
  s.license  =  { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { "Joe Barbour" => "joe@gradoapp.com" }
  s.social_media_url   = "http://twitter.com/@thebarbican19"

  s.platform     = :ios
  s.platform     = :ios, "5.0"
  
  s.source = {:git => 'https://github.com/northernspark/GDLogger.git', :tag => s.version }
  s.source_files = 'GDLogger.{h,m}'
  
end
