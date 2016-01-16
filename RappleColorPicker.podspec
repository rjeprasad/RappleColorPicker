Pod::Spec.new do |s|
s.name             = "RappleColorPicker"
s.version          = "1.1.1"
s.summary          = "RappleColorPicker - Easy to use color pricker for iOS apps"

s.description      = <<-DESC
Flexible and easy to use complete UI color pricker in swift 2.0.
DESC

s.homepage         = "https://github.com/rjeprasad/RappleColorPicker"
s.license          = 'MIT'
s.author           = { "Rajeev Prasad" => "rjeprasad@gmail.com" }
s.source           = { :git => "https://github.com/rjeprasad/RappleColorPicker.git", :tag => s.version.to_s }

s.platform     = :ios, '8.0'
s.requires_arc = true

s.source_files = 'Pod/Classes/*'
end