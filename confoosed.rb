require File.join(File.dirname(__FILE__), 'init')

get "/" do
  "<html><h1>Hello! Are you Confoosed?</h1></html>"
end

get "/schedule/?" do
  
end

get "/sessions/?" do
end

get "/sessions/:id?" do
  @session = Confoosed::Session.first(:id => params[:id])
  erb :session, :locals => { :session => @session }
end

get "/speakers/?" do
  erb :speakers, :locals => { :speakers => Confoosed::Speaker.all }
end

get "/speakers/:id" do # use %r{/speakers/(?<id>\d+)(.html)?} to match .html as well.
  @speaker = Confoosed::Speaker.first(:id=>params[:id])
  erb :speaker, :locals => { :speaker => @speaker }
end

not_found do
end

error do
end
