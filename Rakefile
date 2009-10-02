require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'
require 'rake/contrib/rubyforgepublisher'
require File.join(File.dirname(__FILE__), 'lib', 'support', 'gateway_support')


PKG_VERSION = "1.4.2"
PKG_NAME = "activemerchant"
PKG_FILE_NAME = "#{PKG_NAME}-#{PKG_VERSION}"

PKG_FILES = FileList[
    "lib/**/*", "test/**/*", "script/**/*", "[a-zA-Z]*"
].exclude(/\.svn$/)


desc "Default Task"
task :default => 'test:units'

# Run the unit tests
namespace :test do

  Rake::TestTask.new(:units) do |t|
    t.pattern = 'test/unit/**/*_test.rb'
    t.ruby_opts << '-rubygems'
    t.libs << 'test'
    t.verbose = true
  end

  Rake::TestTask.new(:remote) do |t|
    t.pattern = 'test/remote/**/*_test.rb'
    t.ruby_opts << '-rubygems'
    t.libs << 'test'
    t.verbose = true
  end

end

# Genereate the RDoc documentation
Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'doc'
  rdoc.title    = "ActiveMerchant library"
  rdoc.options << '--line-numbers' << '--inline-source' << '--main=README'
  rdoc.rdoc_files.include('README', 'CHANGELOG')
  rdoc.rdoc_files.include('lib/**/*.rb')
  rdoc.rdoc_files.exclude('lib/tasks')
end

task :install => [:package] do
  `gem install pkg/#{PKG_FILE_NAME}.gem`
end

task :lines do
  lines = 0
  codelines = 0
  Dir.foreach("lib") { |file_name| 
    next unless file_name =~ /.*rb/

    f = File.open("lib/" + file_name)

    while line = f.gets
      lines += 1
      next if line =~ /^\s*$/
      next if line =~ /^\s*#/
      codelines += 1
    end
  }
  puts "Lines #{lines}, LOC #{codelines}"
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "active_merchant"
    gemspec.summary = "Framework and tools for dealing with credit card transactions."
    gemspec.description = "Active Merchant is a simple payment abstraction library used in and sponsored by Shopify. It is written by Tobias Luetke, Cody Fauser, and contributors. The aim of the project is to feel natural to Ruby users and to abstract as many parts as possible away from the user to offer a consistent interface across all supported gateways. This is a patched version that includes unofficial support for the Chase Paymentech Orbital gateway."
    gemspec.email = ""
    gemspec.homepage = "http://activemerchant.org"
    gemspec.authors = ["Tobias Luetke", "Cody Fauser"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

namespace :gateways do
  desc 'Print the currently supported gateways'
  task :print do
    support = GatewaySupport.new
    support.to_s
  end
  
  namespace :print do
    desc 'Print the currently supported gateways in RDoc format'
    task :rdoc do
      support = GatewaySupport.new
      support.to_rdoc
    end
  
    desc 'Print the currently supported gateways in Textile format'
    task :textile do
      support = GatewaySupport.new
      support.to_textile
    end
    
    desc 'Print the gateway functionality supported by each gateway'
    task :features do
      support = GatewaySupport.new
      support.features
    end
  end
end
