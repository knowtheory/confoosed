require "rubygems"
require "date"

require "bundler"
Bundler.require(:default, ENV["RACK_ENV"] || 'development')

here = File.dirname(__FILE__)

db_details = YAML.load(File.open(File.join(here, 'config', 'database.yml')).read)
DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, ENV['DATABASE_URL'] || db_details[ENV["RACK_ENV"] || 'development'])

require File.join(here, "lib", "confoosed", "session")
require File.join(here, "lib", "confoosed", "speaker")
DataMapper.finalize
