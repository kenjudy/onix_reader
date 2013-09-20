# encoding: utf-8
require_relative "../../lib/onix_reader.rb"
require_relative "../../models/book.rb"

describe FileReader::OnixReader do
  let(:source_dir) { "spec/test_data" }
    
  before(:each) do
    allow_any_instance_of(Book).to receive(:new).and_return(double(Book).as_null_object)
  end

  context "on new" do
    subject { FileReader::OnixReader.new(source_dir) }
  
    its(:source_directory) { should == source_dir}

    specify { expect(subject.files.count).to eq 2 }
    
  end
  
  context "on parse" do
    subject { FileReader::OnixReader.new(source_dir) }
    
    it "should create books" do
      subject.stub(files: ["spec/test_data/ebook_onix.xml", "spec/test_data/physical_book_onix.xml"])
      Book.should_receive(:new).exactly(3).times
      subject.parse
    end
    
  end
  
  
end
