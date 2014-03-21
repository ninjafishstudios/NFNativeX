Pod::Spec.new do |s|
  s.name         = "NFNativeX"

  s.version      = "0.2.1"

  s.summary      = "NFNativeX."

  s.homepage     = "https://github.com/ninjafishstudios/NFNativeX"

	s.license      = { :type => 'FreeBSD', :file => 'LICENSE.txt' }

  s.author       = { "williamlocke" => "williamlocke@me.com" }

  s.source       = { :git => "https://github.com/ninjafishstudios/NFNativeX.git", :tag => s.version.to_s }

  s.platform     = :ios, '4.3'
  
  s.source_files =  'Classes/NFNativeX/*.[h,m]'

  s.resources = 'Resources/NFNativeX.bundle'
  
  s.frameworks = 'QuartzCore', 'CoreText'
  
  s.requires_arc = true
    
	s.dependency 'NativeXSDK'
  
end
