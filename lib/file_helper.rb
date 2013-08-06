module FileHelper
    
  def read_lines text
    text.downcase.scan(/[a-z]+/)  
  end  
  
end
