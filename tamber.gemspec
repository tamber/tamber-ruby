$:.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'tamber/version'

spec = Gem::Specification.new do |s|
  s.name = 'tamber'
  s.version = Tamber::VERSION
  s.required_ruby_version = '>= 1.9.3'
  s.summary = 'Ruby bindings for the Tamber API'
  s.description = 'Tamber is the easiest way to put head-scratchingly accurate, real time recommendations in your app.  See https://tamber.com for details.'
  s.homepage = 'https://tamber.com/docs/api'
  s.license = 'MIT'
  s.authors = ['Alexi Robbins', 'Mark Canning']
  s.email = ['alexi@tamber.com', 'argusdusty@tamber.com']

  s.add_dependency('rest-client', '~> 1.4')
  s.add_dependency('json', '~> 1.8.1')
  s.add_dependency('activesupport', '~> 4.2.6')

  s.add_development_dependency('mocha', '~> 0.13.2')
  s.add_development_dependency('shoulda', '~> 3.4.0')
  s.add_development_dependency('test-unit')
  s.add_development_dependency('rake')

  if Gem::Version.new(RUBY_VERSION.dup) > Gem::Version.new('2.0.0')
    s.add_development_dependency("byebug")
    s.add_development_dependency("pry")
    s.add_development_dependency("pry-byebug")
  end

  s.files = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
end
