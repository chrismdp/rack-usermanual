# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "rack-usermanual"
  s.version     = "0.4"
  s.authors     = ["Chris Parsons"]
  s.email       = ["chris.p@rsons.org"]
  s.homepage    = "http://github.com/chrismdp/rack-usermanual"
  s.summary     = %q{Rack endpoint to serve your cucumber features as a user manual}
  s.description = %q{Rack::Usermanual allows you to serve your gherkin feature files as web pages within your application.}
  s.license     = 'MIT'

  s.rubyforge_project = "rack-usermanual"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec,features}/*`.split("\n")
  s.require_paths = ['lib']

  s.add_dependency 'sinatra'
  s.add_dependency 'haml'
  s.add_dependency 'kramdown'
  s.add_dependency 'gherkin'
  s.add_dependency 'rack'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rack-test'
end
