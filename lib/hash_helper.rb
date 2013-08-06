module HashHelper

  def make_hash lines 
    list_of_words = Hash.new(0)
    lines.each do |i| 
      list_of_words[i] += 1 
    end
    list_of_words
  end
  
end
