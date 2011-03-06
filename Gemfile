source :rubygems

def gems(version, *names)
  names.each { |n| gem(n, version) }
end

gem 'sinatra', '~>1.2.0'
gems '~>1.1.pre', 'dm-core', 'dm-validations', 'dm-postgres-adapter', 'dm-migrations', 'dm-tags'

group 'development' do
  gem 'nokogiri', '1.4.4'
end
