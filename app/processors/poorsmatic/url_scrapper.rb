require 'rest-client'
require 'nokogiri'

module Poorsmatic
  class UrlScrapper < TorqueBox::Messaging::MessageProcessor

    def initialize
      # Initialize logging
      @log = TorqueBox::Logger.new(Poorsmatic::UrlScrapper)
    end

    def on_message(url)
      unless Link.where(:url => url).first.nil?
        @log.info "The specified url '#{url}' is already in database, skipping"
        return
      end

      # OK, the url is not found in database, let's fetch it
      if raw = fetch(url)

        page = Nokogiri::HTML(raw)
        body = page.xpath("/html/body").text
        title = page.xpath("/html/head/title").text

        @log.debug "Finding words..."

        c = body.scan(/[\w]+/).size

        @log.debug "Document parsed, got #{c} words"

        begin
          Link.new(:url => url, :title => title).save!
        rescue Exception => e
          # For example Facebook does some Javascript thingy to redirect, skip these
          @log.warn "Couldn't save link for url #{url}; #{e.message}"
        end
      end
    end

    def fetch(url)
      @log.debug "Fetching #{url}..."

      begin
        return RestClient::Request.execute(:method => :get, :url => url, :timeout => 5, :open_timeout => 5)
      rescue Exception => e
        @log.warn "Cannot get #{url}; #{e.message}"
      end
    end
  end
end
