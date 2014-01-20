#!/usr/bin/env ruby   

require 'strano_tools'
require 'json'
require 'optparse'

options = {:path => "."}

OptionParser.new do |opts|
  opts.banner = "Usage: strano.rb [options]"
  opts.on('-p path', '--path=path', 'Application path') { |path| options[:path] = path }
end.parse!


capfile = StranoTools::Capfile.new(options[:path])
data = {:tasks => capfile.tasks, :stages => capfile.stages }.to_json
puts data