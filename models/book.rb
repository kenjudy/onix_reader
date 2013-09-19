require 'nokogiri'

class Book
  
  attr_accessor :isbn13, :isbn10
  
  def initialize(xml)
    self.isbn13 = xml.xpath('//product/productidentifier/b221[text()="15"]/following-sibling::b244').text
    self.isbn10 = xml.xpath('//product/productidentifier/b221[text()="02"]/following-sibling::b244').text
  end
  
end