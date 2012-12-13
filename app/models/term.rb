require 'torquebox-messaging'

class Term < ActiveRecord::Base
  include TorqueBox::Injectors

  attr_accessible :name
  has_many :links, :through => :termcounts

  after_save do |term|
    terms = []

    Term.all.each {|t| terms << t.name}

    topic = TorqueBox::Messaging::Topic.new('/topics/terms')
    topic.publish(terms)
  end
end
