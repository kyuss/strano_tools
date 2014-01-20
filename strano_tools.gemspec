Gem::Specification.new do |spec|
  spec.name        = 'strano_tools'
  spec.version     = '1.0.0'
  spec.date        = '2014-01-20'
  spec.summary     = "Strano Tools"
  spec.description = "Strano Tools to manage capistrano projects"
  spec.authors     = ["Sławomir Zabkiewicz"]
  spec.email       = 'slawomir@zabkiewicz.net'
  spec.files 	   = `git ls-files`.split($/)
  spec.executables =  spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files  = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.license       = 'MIT'
end