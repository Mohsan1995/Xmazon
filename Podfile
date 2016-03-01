# Uncomment this line to define a global platform for your project
# platform :ios, '8.0'
# Uncomment this line if you're using Swift
# use_frameworks!

target 'xmazon' do
pod 'AFNetworking', '~> 2.0'
pod 'AFOAuth2Manager', '2.1.0'
pod 'AMSlideMenu', '1.5.4'
pod 'SWTableViewCell', '~> 0.3.7'

end

target 'xmazonTests' do

end

target 'xmazonUITests' do

end

post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] = ['$(inherited)', 'AMSlideMenuWithoutStoryboards']
        end
    end
end
