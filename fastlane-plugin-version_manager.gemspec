lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/version_manager/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-version_manager'
  spec.version       = Fastlane::VersionManager::VERSION
  spec.author        = 'Ibrahim AshShohail'
  spec.email         = 'me@ibrasho.com'

  spec.summary       = 'Version manager'
  # spec.homepage      = "https://github.com/<GITHUB_USERNAME>/fastlane-plugin-version_manager"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.5'

  # Don't add a dependency to fastlane or fastlane_re
  # since this would cause a circular dependency

  spec.add_dependency 'sem_version', '~> 2.0.1'

  spec.add_development_dependency('bundler')
  spec.add_development_dependency('fastlane', '>= 2.204.3')
  spec.add_development_dependency('pry')
  spec.add_development_dependency('rake')
  spec.add_development_dependency('rspec')
  spec.add_development_dependency('rspec_junit_formatter')
  spec.add_development_dependency('rubocop', '1.12.1')
  spec.add_development_dependency('rubocop-performance')
  spec.add_development_dependency('rubocop-require_tools')
  spec.add_development_dependency('simplecov')
end
