require './lib/waldo/version'

Gem::Specification.new do |s|
  s.name        = 'waldo'
  s.version     = Waldo::VERSION
  s.date        = '2010-04-28'
  s.description = "Simplify search without bloating your controller/model"
  s.summary     = s.description
  s.authors     = ["Marcelo Piva", "Diego Toral"]
  s.email       = 'marcelo@tracersoft.com.br'
  s.files       = ["lib/waldo.rb"]
  s.homepage    = 'http://github/tracersoft/waldo'
  s.license     = 'MIT'

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|s|features)/})
  s.require_paths = ['lib']

  s.add_development_dependency 'bundler', '~> 1.3'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'pry-meta'
end
