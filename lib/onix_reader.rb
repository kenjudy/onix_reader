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
      Dir.glob("#{source_directory}/*.xml").map { |filename| File.new(filename) }
    end
    
    def parse(file)
      xml = Nokogiri::XML(file)
      Book.new(xml)
    end
  end
end
