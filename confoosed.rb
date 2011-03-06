require File.join(File.dirname(__FILE__), 'init')

get "/" do
  "<html><h1>Hello! Are you Confoosed?</h1></html>"
end

get "/schedule/?" do
  
end

get "/sessions/?" do
end

get "/sessions/:id", :provides => 'html' do
  @session = Confoosed::Session.first(:id => params[:id])
  erb :session, :locals => { :session => @session }
end
get "/sessions/:id", :provides => 'json' do
end

get "/speakers/?" do
end

get "/speakers/:id", :provides => 'html' do
  @speaker = Confoosed::Speaker.first(:id=>params[:id])
  erb :speaker, :locals => { :speaker => @speaker }
end
get "/sessions/:id", :provides => 'json' do
end

not_found do
end

error do
end
