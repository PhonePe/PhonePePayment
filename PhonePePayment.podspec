Pod::Spec.new do |s|
  s.name             = 'PhonePePayment'
  s.version          = '2.1.2'
  s.summary          = 'PhonePePayment'

  s.description      = <<-DESC
    Phonepe Payment SDK
                       DESC

  s.homepage         = 'https://github.com/PhonePe/PhonePePayment'
  s.license          = { :type => 'Proprietary', :text => 'Copyright 2021 PhonePe. All rights reserved.' }
  s.author           = { 'PhonePe' => 'ios-support@phonepe.com' }
  s.source           = { :git => 'https://github.com/PhonePe/PhonePePayment.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  
  s.ios.preserve_paths = "PhonePePayment.xcframework"
  s.vendored_frameworks = "PhonePePayment.xcframework"

end
