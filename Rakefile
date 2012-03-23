#!/usr/bin/env rake

task default: :test

# Bundler
require "bundler/gem_tasks"

# MiniTest
require "rake/testtask"
Rake::TestTask.new do |t|
  # ENV["TESTOPTS"] = "-v"
  t.pattern = "spec/*_spec.rb"
end
