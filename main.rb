# Given a start word "bleep" and given dictionary of sorted words.  find count comprising
# all words in dictionary that are "one-away" (defined as replace any one 
# letter with any letter of alphabet, delete any one letter, or
# insert one letter). one-aways also have one-aways, and so on.
#                           
# dictionary.txt can be found at:
# http://docs.oracle.com/javase/tutorial/collections/interfaces/examples/dictionary.txt 
#
# ruby 1.8
# 
 
$LOAD_PATH << File.expand_path('../lib', __FILE__)   

require "benchmark" 
require "hash_helper"     
require "file_helper"
                                         
class Object
  include HashHelper
  include FileHelper
end

def check_for_match item
  if LISTWORDS.has_key?(item)
    LISTWORDS.delete(item)
    true
  else
    false  
  end  
end

def build_permutations wordsym
  word = wordsym.to_s
  length_of_word = word.length
  list_matches = Hash.new(0)

  length_of_word.times do |i| 
    # deletes
    d = word[0...i]+word[i+1..-1] 
       
    if check_for_match(d)
      list_matches[d.to_sym] += 1  unless list_matches.has_key?(d.to_sym)
    end

    LETTERS.each_byte do |l| 

      # replaces
      rep = word[0...i]+l.chr+word[i+1..-1]    
      if check_for_match(rep)
        list_matches[rep.to_sym] += 1  unless list_matches.has_key?(rep.to_sym)
      end

      # inserts
      ins = word[0...i]+l.chr+word[i..-1]
      if check_for_match(ins)
        list_matches[ins.to_sym] += 1  unless list_matches.has_key?(ins.to_sym)
      end            
      # inserts (extra iteration, the last one...stick a letter at the end)
      if(i == word.length-1)
        ins_at_end = word[0...(i+1)]+l.chr        
        if check_for_match(ins_at_end)
          list_matches[ins_at_end.to_sym] += 1  unless list_matches.has_key?(ins_at_end.to_sym)
        end            

      end
    end
  end
  list_matches 
end

LISTWORDS = make_hash(read_lines(File.new('dictionary.txt').read))  # 8 
#LISTWORDS = make_hash(read_lines(File.new('short.txt').read))  # 8 
LETTERS = ("a".."z").to_a.join

word = "bleep"
start_hash = Hash.new(0)
end_hash = Hash.new(0)
temp_hash = Hash.new(0)

start_hash[word.to_sym] += 1
end_hash[word.to_sym] += 1
@totalcount = 0
totaltime = Benchmark.measure do |x|

  while !end_hash.empty? 
    puts "=== START #{@totalcount} =========================================="
  
    end_hash.clear
    temp_hash.clear
  
    start_hash.each_key do |x|
      temp_hash = build_permutations(x) # create hash of one-aways
      temp_hash.each_key do |x| 
        end_hash[x] += 1
        @totalcount += 1 
      end
    end
  
    start_hash.clear                    # iteration of start_hash done.
    start_hash.merge!(end_hash)         # prepare resulting one-aways for next iteration
    puts "=== END #{@totalcount} ============================================" 
      
  end

end 
     
puts totaltime
puts "@totalcount: #{@totalcount}"