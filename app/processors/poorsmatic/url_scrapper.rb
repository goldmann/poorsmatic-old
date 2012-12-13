require 'rest-client'
require 'nokogiri'

module Poorsmatic
  class UrlScrapper < TorqueBox::Messaging::MessageProcessor

    def initialize
      # Initialize logging
      @log = TorqueBox::Logger.new(Poorsmatic::UrlScrapper)
    end

    def on_message(url)
      if raw = fetch(url)
        c, title = parse(raw)

        Link.new(:url => url, :title => title).save!
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

    def parse(data)
      @log.debug "Parsing the document..."

      page = Nokogiri::HTML(data)
      body = page.xpath("/html/body").text
      title = page.xpath("/html/head/title").text

      @log.debug "Finding words..."

      c = body.scan(/[\w]+/).size

      @log.debug "Document parsed, got #{c} words"

      [c, title]
    end

  end
end
