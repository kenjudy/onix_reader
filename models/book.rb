require 'nokogiri'
require 'cgi'
require_relative "../lib/onix_codes.rb"

class Book
  
  # NOTES:
  # format strings do not match existing "Hardback" not "Hardcover"
  # sub_format strings do not match existing 
  # not clear how number of items and number of files appears in ONIX product > b210???
  # how are locale specific descriptions modeled in an ONIX product?
  # do we feed main description (d101) or use othertext d104 with d102 = 01
  # do we feed short description in othertext (d102 = 02)
  # we will lose publisher because ONIX repeats imprint as publisher
  # pimsleur specific nodes: start-lesson, end-lesson, number of lessons, course language id
  # grade/age/lexile? 
  # book with a reading group guide (othertext d102 = 41)
  # book with series? series b017 (publisher code), b018 (series title)
  # book with volume? set b026 (number within set)
  
  attr_accessor :isbn13, :isbn10, :prefix, :title, :subtitle, :workkey, :language, :imprint, :publisher, :trim_size, :errors, :format, :sub_format, :pages, :edition, :number_of_items, :description, :audience_code, :reading_group_guide
  
  def initialize(product_node)
    self.errors = {}
    assign_value(:imprint) { product_node.imprint.b079.text }
    assign_value(:isbn10) { product_node.productidentifier.xpath('b221[text()="02"]/following-sibling::b244').text }
    assign_value(:isbn13) { product_node.productidentifier.xpath('b221[text()="15"]/following-sibling::b244').text }
    assign_value(:language) { OnixCodes.language_code_iso[product_node.language.b252.text] }
    assign_value(:publisher) { product_node.publisher.b081.text }
    assign_value(:subtitle) { product_node.title.b029.text }
    assign_value(:prefix) { product_node.title.b030.text }
    assign_value(:title) { product_node.title.b031.text }
    assign_value(:workkey) { product_node.workidentifier.b244.text }
    assign_value(:trim_size) { "#{product_node.measure.xpath('c093[text()="02"]/following-sibling::c095[text() = "in"]/preceding-sibling::c094').text} x #{product_node.measure.xpath('c093[text()="01"]/following-sibling::c095[text() = "in"]/preceding-sibling::c094').text}" }
    assign_value(:format) { OnixCodes.format_code[product_node.b012.text] }
    assign_value(:sub_format) { OnixCodes.product_form_detail[product_node.b333.text] }
    assign_value(:pages) { product_node.b061.text.to_i }
    assign_value(:edition) { OnixCodes.edition_type_code[product_node.b056.text] }
    assign_value(:number_of_items) { product_node.b210.text.to_i }
    assign_value(:description) { product_node.othertext.xpath('d102[text()="01"]/following-sibling::d104').text }
    assign_value(:audience_code) { OnixCodes.audience_code[product_node.audience.xpath('b204[text()="01"]/following-sibling::b206').text]}
    assign_value(:reading_group_guide) { product_node.othertext.xpath('d102[text()="41"]/following-sibling::d104').text }
  end
  
  private
  
  def assign_value(attr, &block)
    self.send("#{attr}=", block.call)
  rescue => error
    self.errors[attr] = error
  end

end

#BLOCKED - NEED CHILDREN'S TITLE 
# age-high
#  age-high-up-ind
#  age-low
#  age-low-up-ind
# 
#  grade-high
#  grade-high-up-ind
#  grade-low
#  grade-low-up-ind
# 
#  lexile
# 
# 
#  series-id
# 
#  volume

