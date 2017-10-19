Pod::Spec.new do |s|
  s.name         = "Default"
  s.version      = "1.0.0"
  s.summary      = "Modern interface to UserDefaults + Codable support"
  s.description  = <<-DESC
                   Modern interface to UserDefaults + Codable support
                   please refer to README.md for usage details.
                   DESC

  s.homepage     = "https://github.com/Nirma/Default"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Nicholas Maccharoli " => "nmaccharoli@gmail.com" }
  s.social_media_url   = "http://twitter.com/din0sr"
  s.platform     = :ios, "9.0"

  s.ios.deployment_target = "9.0"
  s.osx.deployment_target = "10.10"
  s.watchos.deployment_target = "4.0"
  s.tvos.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/Nirma/Default.git", :tag => "#{s.version}" }
  s.source_files = 'Sources/*.swift'
end
