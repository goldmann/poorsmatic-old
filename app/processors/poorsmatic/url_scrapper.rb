require 'rest-client'
require 'nokogiri'

module Poorsmatic
  class UrlScrapper < TorqueBox::Messaging::MessageProcessor

    def initialize
      # Initialize logging
      @log = TorqueBox::Logger.new(Poorsmatic::UrlScrapper)
    end

    def on_message(url)
      if data = fetch(url)
        @log.info count(data)
      end
    end

    def fetch(url)
      @log.debug "Fetching #{url}..."

      begin
        return RestClient.get(url)
      rescue Exception => e
        @log.warn "Cannot get #{url}; #{e.message}"
      end
    end

    def count(data)
      @log.debug "Parsing the document..."

      page = Nokogiri::HTML(data)
      body = page.xpath("/html/body").text

      @log.debug "Finding words..."

      nb = body.scan(/[\w]+/).size

      @log.debug "Document parsed, got #{nb} words"

      nb
    end

  end
end
