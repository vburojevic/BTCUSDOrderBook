# Platform
platform :ios, '12.0'

# Inhibit all warnings
inhibit_all_warnings!

# Pods
def reactive
  pod 'RxSwift'
  pod 'RxCocoa'
end

def networking
  pod 'Starscream'
end

def shared_pods
  reactive
  networking
end

def testing_pods
  pod 'RxBlocking'
  pod 'RxTest'
  pod 'Nimble'
  pod 'Quick'
end

target 'BTCUSDOrderBook' do
  # Use frameworks
  use_frameworks!

  # Pods for BTCUSDOrderBook
  shared_pods

  target 'BTCUSDOrderBookTests' do
    inherit! :search_paths
    # Pods for testing
    testing_pods
  end

end

# Post install
post_install do |installer|
  installer.pods_project.targets.each do |target|
      if target.name == 'RxSwift'
          target.build_configurations.each do |config|
              if config.name.include? "Debug"
                  config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['$(inherited)', '-D', 'TRACE_RESOURCES']
              end
          end
      end
  end
end
