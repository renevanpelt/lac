Gem::Specification.new do |s|
  s.name          = %q{lac}
  s.version       = "0.0.1"
  s.date          = %q{2018-12-31}
  s.authors       = ["Rene van Pelt"]

  s.summary = %q{lac is a DRY framework for creating scrapers}
  s.files = [
    "lib/lac.rb",
    "lib/lac/application.rb",
    "lib/lac/base.rb",
    "lib/lac/cli.rb",
    "lib/lac/page.rb",
    "lib/lac/base_model.rb",
    
    "Gemfile",

    "views/base.html.haml",
    "views/home.html.haml",
    "views/model.html.haml",
    "views/models.html.haml",
    "views/scrapers.html.haml"
  ]
  s.bindir        = "bin"


  s.executables   = ["lac"]
  s.require_paths = ["lib"]

  s.add_dependency 'fileutils'
  s.add_dependency 'nokogiri'
  s.add_dependency 'colorize'
  s.add_dependency 'activesupport', '>=1.4'
  s.add_dependency 'sinatra'
  s.add_dependency 'haml'

  
end