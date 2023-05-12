Gem::Specification.new do |s|
  s.name        = 'ruby-onfleet'
  s.version     = '1.0.1'
  s.date        = '2023-05-11'
  s.summary     = 'Onfleet Ruby API wrapper package'
  s.description = 'The Onfleet Ruby library provides convenient access to the Onfleet API.'
  s.authors     = ['Dan Menza']
  s.email       = 'dmenza@onfleet.com'
  s.homepage    = 'https://rubygems.org/gems/ruby-onfleet'
  s.license     = 'MIT'

  s.add_dependency('faraday', '~> 1.10.0')

  s.add_development_dependency('rspec', '~> 3.12.0')
  s.add_development_dependency('webmock', '~> 3.18.1')

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ['lib']
end
