# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'

target 'DoorsConsole' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'JWTDecode'
  pod 'ProgressHUD'

  # Pods for DoorsConsole

  target 'DoorsConsoleTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'DoorsConsoleUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_BITCODE'] = 'NO'
      config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
    end
  end
end
