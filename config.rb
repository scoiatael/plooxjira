require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

Dir['config/*.rb', 'actions/github/*.rb', 'actions/jira/*.rb', 'actions/*.rb'].sort.each do |f|
  require_relative f
end
require_relative 'app'
