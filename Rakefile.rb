require 'rubygems'
require 'rake'

task :default => [:test]

task :test do
  ruby "-Itest:test/models:lib" + " test/notifier_test.rb"
end