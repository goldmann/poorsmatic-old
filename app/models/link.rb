class Link < ActiveRecord::Base
  attr_accessible :title, :url
  has_many :terms, :through => :termcounts 
end
