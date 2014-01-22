#!/usr/bin/env ruby   

require File.expand_path(File.dirname(__FILE__) + '/capfile.rb')
require 'json'
require 'optparse'

options = {:path => ".", :output => "capfile.json"}

OptionParser.new do |opts|
  opts.banner = "Usage: strano.rb [options]"
  opts.on('-p path', '--path=path', 'Application path') { |path| options[:path] = path }
  opts.on('-o output', '--output=output', 'Output file') { |output| options[:output] = output}
end.parse!

data = "{}"
begin
	capfile = Capfile.new(options[:path])
	data = {:tasks => capfile.tasks, :stages => capfile.stages }
rescue Exception => e
	data = {:error => e.class.to_s, :message => e.message, :backtrace => e.backtrace.join("\n")}
ensure
	File.open(options[:output],"w") { |file| file.write(data.to_json) }
end

