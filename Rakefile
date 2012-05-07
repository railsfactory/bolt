# encoding: utf-8

require File.expand_path('../config/application', __FILE__)

Bolt::Application.load_tasks

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "bolt"
  gem.homepage = "http://github.com/railsfactory-pramod/bolt"
  gem.license = "MIT"
  gem.summary = %Q{A super cms by railsfactory}
  gem.description = %Q{write description here}
  gem.email = "pramod@railsfactory.com"
  gem.authors = ["railsfactory-pramod"]

  gem.files.include('lib/**/*.rb')
  gem.files.include('lib/**/*.css')
  gem.files.include('lib/**/*.js')
  gem.files.include('lib/**/*.erb')
  gem.files.include('lib/**/*.html')
  gem.files.include('lib/**/*.png')
  gem.files.include('lib/**/*.gif')		
  gem.files.include('lib/**/*.yml')
  gem.files.include('config/**/*.yml')	
 
  gem.files.include('app/**/*.rb')
  gem.files.include('app/**/*.erb')
  gem.files.include('app/**/*.html')

 
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

require 'rcov/rcovtask'
Rcov::RcovTask.new do |test|
  test.libs << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
  test.rcov_opts << '--exclude "gems/*"'
end

task :default => :test

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "bolt #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
