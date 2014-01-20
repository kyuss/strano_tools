StranoTools
======

StranoTools are collection of scripts to manage capistrano based projects.

* bin/parse_capfile.rb - this script will parse your capistrano descriptor and output json list of tasks (with descriptions) and declared variables

Installation
------------

`gem build strano_tools.gemspec`

`gem install strano_tools.gemspec`

Usage
------------

`parse_capfile.rb -p PATH # where PATH is your project path, default is "."`

Example
------------
`parse_capfile.rb`
