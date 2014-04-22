#!/usr/bin/env rake
require 'rake'
begin
  require 'rdoc/task'
rescue LoadError
  require 'rdoc/rdoc'
  require 'rdoc/rdoctask'
  RDoc::Task = Rake::RDocTask
end
require 'rake/testtask'

#Bundler::GemHelper.install_tasks

desc 'Default: run unit tests.'
task :default => :test

#desc 'Run all tests for redmine_mylyn_connector.'
Rake::TestTask.new(:test) do |t|
  t.libs   << 'lib'
  t.libs   << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

#desc 'Build documentation for redmine_mylyn_connector.'
RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Redmine Mylyn Connector'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
