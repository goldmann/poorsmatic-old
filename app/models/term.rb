class Term < ActiveRecord::Base
  include TorqueBox::Injectors

  attr_accessible :name

  has_many :links, :through => :termcounts

  # We want to be sure that name is entered and is unique
  validates :name, :presence => true
  validates :name, :uniqueness => true

  # If the database of terms has been changed (new term added,
  # term deleted, term modified), we need to update the
  # terms which we watch on Twitter, therefore we send all terms
  # to the terms topic.
  after_save :publish_terms
  after_destroy :publish_terms

  def publish_terms
    terms = []

    # Let's find all terms we already have in database
    Term.all.each {|t| terms << t.name}

    # Fetch the terms topic
    topic = fetch('/topics/terms')
    # Send the message (an array of terms) to the topic
    # even if this is an empty list
    topic.publish(terms)
  end
end
