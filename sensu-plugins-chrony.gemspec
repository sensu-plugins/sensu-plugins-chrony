# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'date'

require_relative 'lib/sensu-plugins-chrony'

Gem::Specification.new do |s|
  s.authors = [
    'Matteo Cerutti',
    'Sensu-Plugins and contributors'
  ]
  s.date                   = Date.today.to_s
  s.description            = 'This plugin provides facilities for monitoring Chrony NTP'
  s.email                  = [
    '<matteo.cerutti@hotmail.co.uk>',
    '<sensu-users@googlegroups.com>'
  ]
  s.executables            = Dir.glob('bin/**/*').map { |file| File.basename(file) }
  s.files                  = Dir.glob('{bin,lib}/**/*') + %w[LICENSE README.md CHANGELOG.md]
  s.homepage               = 'https://github.com/m4ce/sensu-plugins-chrony'
  s.license                = 'MIT'
  s.metadata               = { 'maintainer' => '@m4ce',
                               'development_status' => 'active',
                               'production_status' => 'stable',
                               'release_draft' => 'false',
                               'release_prerelease' => 'false' }
  s.name                   = 'sensu-plugins-chrony'
  s.platform               = Gem::Platform::RUBY
  s.post_install_message   = 'You can use the embedded Ruby by setting EMBEDDED_RUBY=true in /etc/default/sensu'
  s.require_paths          = ['lib']
  s.required_ruby_version  = '>= 2.3.0'
  s.summary                = 'Sensu plugins for monitoring Chrony NTP'
  s.test_files             = s.files.grep(%r{^(test|spec|features)/})
  s.version                = SensuPluginsChrony::Version::VER_STRING

  s.add_development_dependency 'bundler',                   '~> 2.1'
  s.add_development_dependency 'github-markup',             '~> 4.0'
  s.add_development_dependency 'rake',                      '~> 13.0'
  s.add_development_dependency 'redcarpet',                 '~> 3.2'
  s.add_development_dependency 'rspec',                     '~> 3.4'
  s.add_development_dependency 'rubocop',                   '~> 0.81.0'
  s.add_development_dependency 'yard',                      '~> 0.8'

  s.add_runtime_dependency 'sensu-plugin', '~> 4.0'
end
