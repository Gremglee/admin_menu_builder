$:.push File.expand_path("../lib", __FILE__)
require 'admin_menu_builder/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'admin_menu_builder'
  s.version     = AdminMenuBuilder::VERSION
  s.authors     = ['Andrey Skuryatin']
  s.email       = ['andrey.skuryatin@gmail.com']
  s.summary     = 'DSL for generating admin menu'
  s.description = 'DSL for generating admin menu'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '~> 4.1.0'

  s.add_development_dependency 'sqlite3'
end