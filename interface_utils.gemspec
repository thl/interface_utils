$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "interface_utils/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "interface_utils"
  s.version     = InterfaceUtils::VERSION
  s.authors     = ["Andres Montano"]
  s.email       = ["amontano@virginia.edu"]
  s.homepage    = "http://subjects.kmaps.virginia.edu"
  s.summary     = "Helper methods common to all THL and shanti apps."
  s.description = "Helper methods common to all THL and shanti apps."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
