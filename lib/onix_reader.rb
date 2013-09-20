require 'nokogiri'
require_relative "../models/book.rb"

module FileReader
  class OnixReader
    
    def initialize(source_directory = "")
      @source_directory = source_directory
    end
    
    def source_directory
      @source_directory
    end
    
    def files
      Dir.glob("#{source_directory}/*.xml")
    end
    
    def parse
      files.each do |filename|
        raw_xml = ""
        File.open(filename) { |f| raw_xml << f.read }
        onix = Nokogiri::Slop(raw_xml, encoding='UTF-8').ONIXmessage
        onix.xpath("product").each { |product| Book.new(product)}
      end
    end
  end
end
