Gem::Specification.new do |gem|
  gem.add_dependency 'omniauth', '~> 1.0'
  gem.name          = "omniauth-khronos"
  gem.version       = "0.1.0"
  gem.authors       = ["James Riordon"]
  gem.email         = ["webmaster@khronos.org"]
  gem.description   = %q{A Khronos OAuth2 strategy for OmniAuth 1.x}
  gem.summary       = %q{A Khronos OAuth2 strategy for OmniAuth 1.x}
  gem.homepage      = "https://www.khronos.org/"
  gem.files         = `git ls-files`.split("\n")
  gem.require_paths = ["lib"]
end

