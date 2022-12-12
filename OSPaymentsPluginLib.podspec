Pod::Spec.new do |s|
  s.name             = 'OSPaymentsPluginLib'
  s.version          = '1.1.0'
  s.summary          = 'The `OSPaymentsPluginLib-iOS` is a library build using `Swift` that lets you set a payment experience using Apple Pay.'
  s.description      = <<-DESC
  The `OSPaymentsPluginLib-iOS` is a library build using `Swift` that lets you set a payment experience using Apple Pay. It allows to set the payment's details, such as the merchant’s information, payment amount and currency, as well as shipping and billing address. This information can then used to process a payment within an app.

  The `OSPMTActionDelegate` protocol, along with the class that implements it - `OSPMTPayments` - allows this interaction, providing the following operations:
  - Setup Payment Configuration
  - Check if Device is Ready for Payment
  - Set Details and Trigger Payment
                       DESC
  s.homepage         = 'https://github.com/OutSystems/OSPaymentsLib-iOS'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Mobile Ecosystem Team' => 'rd.mobileecosystem.team@outsystems.com' }
  s.source           = { :git => 'https://github.com/OutSystems/OSPaymentsLib-iOS.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.swift_versions = '5.0'

  s.source_files = 'OSPaymentsLib/**/*.swift'
  s.dependency 'StripePayments', '23.2.0'
end