require 'nokogiri'

module Lac

  class Page

    attr_accessor :html

    # Need better flow for what this does.

    def try_css_attr(css, attr)
      if element = self.try_css(css)
        element.attr(attr)
      else
        nil
      end
    end

    def try_css_parent_attr(css, attr)
      if element = try_css(css)
        element.parent.attr(attr)
      else
        nil
      end
    end

    def try_css(css)
      self.html.css(css).first
    end


    # Simply gets a webpage based on a url.
    # from_cache = true (default) will take a cached version
    # if it exists.

    def self.get_page(url, from_cache = true)
      url_hash = Digest::SHA256.hexdigest(url)
      filename = "cache/#{url_hash}"
      if from_cache && File.file?(filename)
        result = open(filename).read
        puts "Gotten #{filename} from cache"
      else
        result = open(url).read
        File.write(filename, result)
        puts "Written cache file #{filename}"
      end
      return result
    end

    def initialize html: nil
      self.html = html
    end

    # helpers for seamless initialisation no matter what starting point
    
    def self.by_url(url)
      self.new(html: Nokogiri::HTML(get_page(url)))
    end

    def self.by_html_string(html_string)
      self.new(html: Nokogiri::HTML(html_string))
    end

    def self.by_html(html)
      self.new(html: html)
    end


    # Returns a collection of pages based on a selector.
    # Use to collect a collection of elements from a page.
    def collection_by_selector(selector)
      self.html.css(selector).map{|item| Lac::Page.by_html(item)}
    end

  end

end
