Pod::Spec.new do |s|
  s.name      = 'MobileAnalyticsChartSwift'
  s.version   = '1.1.0'
  s.homepage  = 'https://github.com/yoomoney-tech/mobile-analytics-chart-swift/browse'
  s.license   = {
    :type => "MIT",
    :file => "LICENSE"
  }
  s.authors = 'YooMoney'
  s.summary = 'Mobile Analytics Chart'

  s.source = {
    :git => 'https://github.com/yoomoney-tech/mobile-analytics-chart-swift.git',
    :tag => s.version.to_s
  }

  s.ios.deployment_target = '11.0'
  s.swift_version = '5.0'

  s.ios.source_files  = 'MobileAnalyticsChartSwift/**/*.{h,swift}', 'MobileAnalyticsChartSwift/*.{h,swift}'

  s.ios.framework  = 'UIKit'
end
