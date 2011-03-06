module Confoosed
  class Speaker
    include DataMapper::Resource
    
    property :id,         Serial
    property :name,       String, :length => 255
    property :url,        String, :length => 255, :format => :url
    
    has n, :sessions, :through => Resource
  end
end
