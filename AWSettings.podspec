Pod::Spec.new do |s|
  s.name             = "AWSettings"
  s.version          = "0.1.0"
  s.summary          = "A short description of AWSettings."
  s.description      = <<-DESC
                       An optional longer description of AWSettings

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/Ashton-W/AWSettings"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = "Ashton Williams"
  s.source           = { :git => "https://github.com/Ashton-W/AWSettings.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/AshtonDev'
  s.platform         = :ios, '7.0'
  s.requires_arc     = true
  s.source_files     = 'AWSettings/*'
  s.public_header_files = 'AWSettings/*.h'
end
