Gem::Specification.new do |s|
  s.name        = 'ruby-onfleet'
  s.version     = '1.0.4'
  s.date        = '2024-06-10'
  s.summary     = 'Onfleet Ruby API wrapper package'
  s.description = 'The Onfleet Ruby library provides convenient access to the Onfleet API.'
  s.authors     = ['Dan Menza']
  s.email       = 'support@onfleet.com'
  s.homepage    = 'https://rubygems.org/gems/ruby-onfleet'
  s.license     = 'MIT'
  s.metadata    = { 'source_code_uri' => 'https://github.com/onfleet/ruby-onfleet' }

  s.add_dependency('faraday', '~> 2.9.0')
  s.add_dependency('faraday-net_http', '~> 3.1.0')
  s.add_dependency('faraday-rate_limiter', '~> 0.0.4')
  s.add_dependency('json', '~> 2.6.3')
  s.add_dependency('uri', '~> 0.12.1')

  s.add_development_dependency('rspec', '~> 3.12.0')
  s.add_development_dependency('webmock', '~> 3.18.1')

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ['lib']
end
