require 'spec_helper'

describe "FileHelper" do
    
  describe "when input file" do
    before do
      class Object; include FileHelper; end
    end
    describe "exists" do
      it "returns array of words" do
        word_array = read_lines(File.new('test.txt').read)
        word_array.should == ["aaa", "bbb", "ccc", "ddd", "eee"]      
      end
    end                  
    describe "does not exist" do
      it "returns exception" do
        expect {
          read_lines(File.new('nonexistent.txt').read)
        }.to raise_error(/No such file or directory/)
      end
    end                                                    
  end
end
