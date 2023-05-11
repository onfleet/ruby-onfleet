Gem::Specification.new do |s|
  s.name        = 'onfleet'
  s.version     = '1.0.0'
  s.date        = '2023-05-11'
  s.summary     = 'Onfleet Ruby API wrapper package'
  s.description = 'The Onfleet Ruby library provides convenient access to the Onfleet API.'
  s.authors     = ['Dan Menza']
  s.email       = 'dmenza@onfleet.com'
  s.homepage    = 'https://rubygems.org/gems/ruby-onfleet'
  s.license     = 'MIT'

  s.add_dependency('faraday')
  s.add_dependency('json')
  s.add_dependency('uri')

  s.add_development_dependency('rspec')
  s.add_development_dependency('webmock')

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ['lib']
end
