$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'liquid_haml/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'liquid-haml'
  s.version     = LiquidHaml::VERSION
  s.authors     = ['jaen']
  s.email       = ['jaennirin@gmail.com']
  s.homepage    = 'http://www.nope.com'
  s.summary     = 'Use HAML templates on clientside too!'
  s.description = 'For the time being it\'s just a dummy controller serving server-rendered hamls.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['spec/**/*']

  s.require_paths = ['lib']

  s.add_dependency 'rails', '>= 4.0.0'
  s.add_dependency 'haml',  '~> 4.0.0'
  s.add_dependency 'hashie', '~> 2.1.1'
  s.add_dependency 'jquery-rails'
  s.add_development_dependency 'rspec'
end
