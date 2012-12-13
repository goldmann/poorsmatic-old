class TermCount < ActiveRecord::Base
  attr_accessible :count
  belongs_to :term
  belongs_to :link
end
