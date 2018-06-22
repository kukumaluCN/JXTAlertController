Pod::Spec.new do |s|

  # 简介
  s.name = 'JXTAlertController'
  s.summary = 'A library easy to use UIAlertViewController on iOS.'
  s.authors = { 'kukumaluCN' => '1145049339@qq.com' }
  s.social_media_url = 'https://www.jianshu.com/u/c8f8558a4b1d'

  # 版本信息
  s.version = '1.0.0'
  s.license = { :type => 'MIT', :file => 'LICENSE' }

  # 地址
  s.homepage = 'https://github.com/kukumaluCN/JXTAlertController'
  s.source = { :git => 'https://github.com/kukumaluCN/JXTAlertController.git', :tag => s.version.to_s }

  # 系统
  s.requires_arc = true
  s.platform = :ios, '8.0'
  s.ios.deployment_target = '8.0'

  # 文件
  s.source_files = 'JXTAlertController/*.{h,m}'
  # s.public_header_files = 'JXTAlertController/**/*.{h}'
  # s.resources = "JXTAlertController/JXTAlertController/*.xcassets"


  # 依赖
  # s.libraries = 'sqlite3'
  # s.frameworks = 'UIKit', 'CoreFoundation', 'QuartzCore'
  # s.dependency "JSONKit", "~> 1.4"

end

