#
# Be sure to run `pod lib lint HistoryView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "HistoryView"
  s.version          = "1.0.0"
  s.summary          = "HistoryView` enables to manage and transition preView."

  s.description      = <<-DESC
                       HistoryView

                       enables to manage and transition preView.
                       DESC

  s.homepage         = "https://github.com/recruit-lifestyle/HistoryView"
  s.screenshots      = "https://github.com/recruit-lifestyle/HistoryView/wiki/images/screen_shot.png"
  s.license          = 'MIT'
  s.author           = { "Nonchalant" => "t_ihara@waku-2.com" }
  s.source           = { :git => "https://github.com/recruit-lifestyle/HistoryView.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/l_index'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'HistoryView' => ['Pod/Assets/*.png']
  }

end
