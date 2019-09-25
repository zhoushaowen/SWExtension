Pod::Spec.new do |s|

  s.name         = "SWExtension"

  s.version      = "1.7.3.15"

  s.homepage      = 'https://github.com/zhoushaowen/SWExtension'

  s.ios.deployment_target = '8.0'

  s.summary      = "常用扩展"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author       = { "Zhoushaowen" => "348345883@qq.com" }

  s.source       = { :git => "https://github.com/zhoushaowen/SWExtension.git", :tag => s.version }
  
  # s.source_files  = "SWExtension/SWExtension/*.{h,m}","SWExtension/SWExtension/**/*.{h,m}"

  # s.source_files  = "SWExtension/SWExtension/SWExtension.h"
  
  s.requires_arc = true

  s.dependency 'MBProgressHUD'

  s.dependency 'ReactiveObjC'


  s.subspec 'Core' do |ss|

    ss.source_files = "SWExtension/SWExtension/Core/*.{h,m}"

    ss.subspec 'UIKit' do |sss|

      sss.source_files = "SWExtension/SWExtension/Core/UIKit/*.{h,m}"

    end

    ss.subspec 'Foundation' do |sss|

      sss.source_files = "SWExtension/SWExtension/Core/Foundation/*.{h,m}"

    end

  end

  s.subspec 'Authorization' do |ss|

  # ss.source_files = "SWExtension/SWExtension/Core/Authorization/*.{h,m}"

    ss.subspec 'PhotoLibrary' do |sss|

      sss.source_files = "SWExtension/SWExtension/Authorization/PhotoLibrary/*.{h,m}"
      sss.resource = "SWExtension/SWExtension/Authorization/PhotoLibrary/SWPhotoLibraryAuthorization.bundle"
    end

    ss.subspec 'Camera' do |sss|

      sss.source_files = "SWExtension/SWExtension/Authorization/Camera/*.{h,m}"
      sss.resource = "SWExtension/SWExtension/Authorization/Camera/SWCameraAuthorization.bundle"

    end

    ss.subspec 'Microphone' do |sss|

      sss.source_files = "SWExtension/SWExtension/Authorization/Microphone/*.{h,m}"
      sss.resource = "SWExtension/SWExtension/Authorization/Microphone/SWMicrophoneAuthorization.bundle"

    end

    ss.subspec 'SpeechRecognizer' do |sss|

      sss.source_files = "SWExtension/SWExtension/Authorization/SpeechRecognizer/*.{h,m}"
      sss.resource = "SWExtension/SWExtension/Authorization/SpeechRecognizer/SWSpeechRecognizerAuthorization.bundle"

    end

  end
  
 



end
