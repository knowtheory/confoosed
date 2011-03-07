module Confoosed
  class Speaker
    include DataMapper::Resource
    
    property :id,          Serial
    property :name,        String, :length => 255
    property :url,         String, :length => 255, :format => :url
    property :photo_url,   String, :length => 255, :format => :url
    property :affiliation, String, :length => 255
    property :profile,     Text
    property :twitter,     String, :length => 255
    
    has n, :sessions, :through => Resource
  end
end
  