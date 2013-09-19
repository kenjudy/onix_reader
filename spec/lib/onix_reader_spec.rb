# encoding: utf-8
require_relative "../../lib/onix_reader.rb"
require_relative "../../models/book.rb"

describe FileReader::OnixReader do
  let(:source_dir) { "../xml/onix" }
  let(:file) { double(File) }
  
  before(:each) do
    Nokogiri::XML::Document.stub(parse: Nokogiri::XML("<xml></xml>"))
    Dir.stub(glob: %w[foo_onix.xml])
    File.stub(new: file)
  end

  context "as a file reader" do
    subject { FileReader::OnixReader.new(source_dir) }
  
  
    it { should_not be_nil }
  
    its(:source_directory) { should == source_dir}
  
    it "should list files entries" do
      expect(subject.files).to eq [file]
    end
  
  end
  
  context "as parsed book" do
    subject {FileReader::OnixReader.new().parse(file)}
  
    its(:class) {should == Book}

    it "should create book with onix xml" do
      Book.should_receive(:new).with(Nokogiri::XML("<xml></xml>"))
      subject
    end
  end
  
end
