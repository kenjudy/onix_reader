# encoding: utf-8
require_relative "../../models/book.rb"

describe Book do
  context "physical book" do
    before(:each) do
      file = File.new('spec/test_data/physical_book_onix.xml')
      @product_node =  Nokogiri::Slop(file.read, encoding='UTF-8').ONIXmessage.product
      file.close
    end

    subject(:book) { Book.new(@product_node)}
  
    its(:isbn13) { should == '9781476716534' }
    its(:isbn10) { should == '1476716536' }
    its(:prefix) { should == 'A' }
    its(:title) { should == 'Great Game' }
    its(:subtitle) { should == 'The Forgotten Leafs & the Rise of Professional Hockey' }
    its(:workkey) { should == '408743661' }
    its(:language) { should == 'English' }
    its(:imprint) { should == 'Simon & Schuster' }
    its(:publisher) { should == 'Simon & Schuster' }
    its(:trim_size) { should == "6.25 x 9.25" }
    its(:format) { should == 'Hardback' }
    its(:sub_format) { should be_nil }
    its(:pages) { should == 368 }
    its(:edition) { should be_nil }
    its(:number_of_items) { should == 3 }
    its(:description) { should include("Drawing on extensive archival") }
    its(:audience_code) { should include("General/trade") }
    
    it "should have reading group guide" 
      
    it "should have errors for nil values" do
      expect(subject.errors.keys).to eq [:sub_format, :edition]
    end
  end
  
  context "audio book" do
  end
  
  context "ebook" do
    before(:each) do
      file = File.new('spec/test_data/ebook_onix.xml')
      @product_node =  Nokogiri::Slop(file.read, encoding='UTF-8').ONIXmessage.xpath("product")[0]
      file.close
    end
    subject(:book) { Book.new(@product_node)}
    its(:trim_size) { should be_nil }
    its(:format) { should == 'Electronic book text' }
    its(:number_of_items) { should be_nil }
  end
end