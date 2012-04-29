require 'open-uri'  ## Lets you call open() with a URL rather than a file

module UrbanDictionaryScraper

  class Error < StandardError ; end

  ## Most of this is pulled directly from: https://github.com/nickcharlton/urbanscraper
  ## He provides a service (http://urbanscraper.herokuapp.com/), but I'd prefer to do my lookup directly and avoid another point of failure on the network that I don't control.

  def self.define(term)
    begin
      doc = Nokogiri::HTML(open('http://www.urbandictionary.com/define.php?term=' + term))
   
      definition = doc.xpath("/html[1]/body[1]/div[3]/div[1]/table[1]/tr[1]/td[2]/div[1]/table[1]/tr[2]/td[2]/div[@class='definition']/node()")

      if definition.any?
        result = {:definition => sanitize(definition)}
        example = doc.xpath("/html[1]/body[1]/div[3]/div[1]/table[1]/tr[1]/td[2]/div[1]/table[1]/tr[2]/td[2]/div[@class='example']/node()")

        if example.any?
          result[:example] = sanitize(example)
        end

        result
      else
        nil
      end
    rescue => e
      raise UrbanDictionaryScraper::Error.new(e)
    end
  end

  def self.sanitize(nodes)
    nodes.map(&:to_s).join.gsub("\r", "\n").gsub(/<br[\/ ]*>/, "\n")
  end

end
