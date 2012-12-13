class Term < ActiveRecord::Base
  include TorqueBox::Injectors

  attr_accessible :name
  has_many :links, :through => :termcounts

  after_save :publish_terms
  after_destroy :publish_terms

  def publish_terms
    terms = []

    # Let's find all terms we already have in database
    Term.all.each {|t| terms << t.name}

    # Fetch the terms topic
    topic = fetch('/topics/terms')
    # Send the message (an array of terms) to the topic
    topic.publish(terms)
  end
end
