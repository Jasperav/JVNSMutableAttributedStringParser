Pod::Spec.new do |s|
  s.name             = 'JVNSMutableAttributedStringParser'
  s.version          = '0.1.3'
  s.summary          = 'A short description of JVNSMutableAttributedStringParser.'


  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Jasperav/JVNSMutableAttributedStringParser'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jasperav' => 'Jasperav@hotmail.com' }
  s.source           = { :git => 'https://github.com/Jasperav/JVNSMutableAttributedStringParser.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'

  s.source_files = 'JVNSMutableAttributedStringParser/Classes/**/*'
  
end
