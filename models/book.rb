require 'nokogiri'
require 'cgi'
require_relative "../lib/onix_codes.rb"

class Book
  
  # NOTES:
  # format strings do not match existing "Hardback" not "Hardcover"
  # sub_format strings do not match existing 
  
  attr_accessor :isbn13, :isbn10, :title, :subtitle, :workkey, :language, :imprint, :publisher, :trim_size, :errors, :format, :sub_format
  
  def initialize(raw_xml)
    self.errors = {}
    onix = Nokogiri::Slop(raw_xml, encoding='UTF-8').ONIXmessage
    self.imprint = handle_errors { onix.product.imprint.b079.text }
    self.isbn10 = handle_errors { onix.product.productidentifier.xpath('b221[text()="02"]/following-sibling::b244').text }
    self.isbn13 = handle_errors { onix.product.productidentifier.xpath('b221[text()="15"]/following-sibling::b244').text }
    self.language = handle_errors { OnixCodes.language_code_iso[onix.product.language.b252.text] }
    self.publisher = handle_errors { onix.product.publisher.b081.text }
    self.subtitle = handle_errors { onix.product.title.b029.text }
    self.title = handle_errors { onix.product.title.b203.text }
    self.workkey = handle_errors { onix.product.workidentifier.b244.text }
    self.trim_size = trim_size_string(onix)
    #self.format = handle_errors { OnixCodes.format_code[onix.product.b012.text] }
    assign_value(:format) { OnixCodes.format_code[onix.product.b012.text] }
    assign_value(:sub_format) { OnixCodes.product_form_detail[onix.product.b333.text] }
    
  end
  
  private
  
  def trim_size_string(onix)
    handle_errors { "#{onix.product.measure.xpath('c093[text()="02"]/following-sibling::c095[text() = "in"]/preceding-sibling::c094').text} x #{onix.product.measure.xpath('c093[text()="01"]/following-sibling::c095[text() = "in"]/preceding-sibling::c094').text}" }
  end
    
  def handle_errors(&block)
    return block.call
  rescue => error
    self.errors["foo"] = error
    return ""
  end
  
  def assign_value(attr, &block)
    self.send("#{attr}=", block.call)
  rescue => error
    self.errors[attr] = error
  end

  def languages
    { "eng" => "English"}
  end
end