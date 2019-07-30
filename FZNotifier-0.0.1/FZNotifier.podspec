Pod::Spec.new do |s|
  s.name = "FZNotifier"
  s.version = "0.0.1"
  s.summary = "A short description of FZNotifier."
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"wufuzeng"=>"wufuzeng_lucky@sina.com"}
  s.homepage = "https://github.com/wufuzeng/FZNotifier"
  s.description = "TODO: Add long description of the pod here."
  s.source = { :path => '.' }

  s.ios.deployment_target    = '8.0'
  s.ios.vendored_framework   = 'ios/FZNotifier.framework'
end
