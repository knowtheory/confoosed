module Confoosed
  class Session
    include DataMapper::Resource
    
    property :id,         Serial
    property :name,       String, :length => 255
    property :url,        String, :length => 255, :format => :url
    property :start_at,  DateTime
    property :end_at,    DateTime
    
    has n, :speakers, :through => Resource
    has_tags # comes from dm-tags
  end
end
