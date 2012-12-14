class Link < ActiveRecord::Base
  attr_accessible :title, :url

  has_many :terms, :through => :termcounts

  # Ensure that title and url are provided
  validates :title, :url, :presence => true
  # Ensure that url is unique, we're not interested
  # in the same url again
  validates :url, :uniqueness => true
end
