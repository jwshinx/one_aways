require 'spec_helper'

describe "HashHelper" do
    
  describe "with input file of words: aaa, bbb, ccc, ddd, eee" do
    describe "creates hash pair with key/value: work/1" do
      before do
        class Object; include HashHelper; end
        @listwords = make_hash(read_lines(File.new('test.txt').read)) 
      end
                          
      it "returns true for has-key 'aaa'" do
        @listwords.has_key?('aaa').should be_true
      end
      it "returns true for has-key 'bbb'" do
        @listwords.has_key?('bbb').should be_true
      end
      it "returns true for has-key 'ccc'" do
        @listwords.has_key?('ccc').should be_true
      end
      it "returns true for has-key 'ddd'" do
        @listwords.has_key?('ddd').should be_true
      end
      it "returns true for has-key 'eee'" do
        @listwords.has_key?('eee').should be_true
      end
    end                                                    
  end
end
