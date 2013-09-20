# encoding: utf-8
require_relative "../../lib/onix_reader.rb"
require_relative "../../models/book.rb"

describe FileReader::OnixReader do
  let(:source_dir) { "../xml/onix" }
  let(:file) { double(File, read: "<xml><foo>blah</foo>") }
  let(:book) { double(Book).as_null_object}
  
  before(:each) do
    Dir.stub(glob: %w[foo_onix.xml])
    File.stub(new: file)
  end

  context "as a file reader" do
    subject { FileReader::OnixReader.new(source_dir) }
  
  
    it { should_not be_nil }
  
    its(:source_directory) { should == source_dir}
  
    its(:files) { should == [file]}
  
  end
  
  context "as parsed book" do
    
    it "should create book with onix xml" do
      Book.should_receive(:new).with(file.read)
      FileReader::OnixReader.new().parse(file)
    end
  end
  
end
