Pod::Spec.new do |s|

  s.name         = "SWExtension"

  s.version      = "1.6.1"

  s.homepage      = 'https://github.com/zhoushaowen/SWExtension'

  s.ios.deployment_target = '8.0'

  s.summary      = "常用扩展"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author       = { "Zhoushaowen" => "348345883@qq.com" }

  s.source       = { :git => "https://github.com/zhoushaowen/SWExtension.git", :tag => s.version }
  
  # s.source_files  = "SWExtension/SWExtension/*.{h,m}","SWExtension/SWExtension/**/*.{h,m}"

    s.source_files  = "SWExtension/SWExtension/SWExtension.h"
  
  s.requires_arc = true

  s.dependency 'MBProgressHUD'
  
  s.subspec 'UIKit' do |ss|

  ss.source_files = "SWExtension/SWExtension/UIKit/*.{h,m}"

  end

  s.subspec 'Foundation' do |ss|

  ss.source_files = "SWExtension/SWExtension/Foundation/*.{h,m}"

  end



end
