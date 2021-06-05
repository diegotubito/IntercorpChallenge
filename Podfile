# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def shared_pods
  pod 'Firebase'
  pod 'Firebase/Auth'
  pod 'Firebase/Database'
end

target 'IntercorpChallenge' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for IntercorpChallenge

  shared_pods

  target 'IntercorpChallengeTests' do
    inherit! :search_paths
    # Pods for testing
    shared_pods
  end

end
