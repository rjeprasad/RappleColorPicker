Pod::Spec.new do |s|
s.name             = "RappleColorPicker"
s.version          = "3.0.3"
s.summary          = "RappleColorPicker - iOS Color picker"

s.description      = <<-DESC
Flexible and easy to use `UI color pricker` with swift 4.
DESC

s.homepage         = "https://github.com/rjeprasad/RappleColorPicker"
s.license          = 'MIT'
s.author           = { "Rajeev Prasad" => "rjeprasad@gmail.com" }
s.source           = { :git => "https://github.com/rjeprasad/RappleColorPicker.git", :tag => s.version.to_s }

s.platform     = :ios, '9.0'
s.requires_arc = true
s.preserve_paths = 'LICENSE', 'README.md'
s.source_files = 'Pod/Classes/*'
end
