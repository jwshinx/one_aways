# Given a start word "causes"; given dictionary of sorted words.  find count comprising
# all words in dictionary that are "one-away" (defined as replace any one 
# letter with any letter of alphabet, delete any one letter, or
# insert one letter). one-aways also have one-aways, and so on.
#                           
# dictionary.txt can be found at:
# http://docs.oracle.com/javase/tutorial/collections/interfaces/examples/dictionary.txt 
#
# ruby 1.9.3
# 

require "benchmark"

def read_lines text
  text.downcase.scan(/[a-z]+/)  
end

def make_hash lines 
  list_of_words = Hash.new(0)
  lines.each do |i| 
    list_of_words[i] += 1 
  end
  return list_of_words
end

def check_for_match item
  if LISTWORDS.has_key?(item)
    LISTWORDS.delete(item)
    yield(item)
  end
end

def build_permutations wordsym
  word = wordsym.to_s
  length_of_word = word.length
  list_matches = Hash.new(0)

  length_of_word.times do |i| 
    # deletes
    d = word[0...i]+word[i+1..-1]
    check_for_match(d) do |x|
      list_matches[x.to_sym] += 1  unless list_matches.has_key?(x.to_sym)
    end

    LETTERS.each_byte do |l| 

      # replaces
      rep = word[0...i]+l.chr+word[i+1..-1]
      check_for_match(rep) do |y|
        list_matches[y.to_sym] += 1  unless list_matches.has_key?(y.to_sym)
      end

      # inserts
      ins = word[0...i]+l.chr+word[i..-1]
      check_for_match(ins) do |x|
        list_matches[x.to_sym] += 1 unless list_matches.has_key?(x.to_sym)
      end
      # inserts (extra iteration, the last one...stick a letter at the end)
      if(i == word.length-1)
        ins_at_end = word[0...(i+1)]+l.chr
        check_for_match(ins_at_end) do |x|
          list_matches[x.to_sym] += 1 unless list_matches.has_key?(x.to_sym)
        end
      end
    end
  end
  list_matches 
end

#LISTWORDS = make_hash(read_lines(File.new('dictionary.txt').read))  # 8 
LISTWORDS = make_hash(read_lines(File.new('short.txt').read))  # 8 
LETTERS = ("a".."z").to_a.join

word = "causes"
mytemphash1 = Hash.new(0)
mytemphash2 = Hash.new(0)
temphash = Hash.new(0)

mytemphash1[word.to_sym] += 1
mytemphash2[word.to_sym] += 1
@totalcount = 0
totaltime = Benchmark.measure do |x|

  while !mytemphash2.empty? 
    puts "=== START #{@totalcount} =========================================="
  
    mytemphash2.clear
    temphash.clear
  
    mytemphash1.each_key do |x|
      temphash = build_permutations(x) 
      temphash.each_key do |x| 
        mytemphash2[x] += 1 #unless @myanswers.has_key?(x)
        @totalcount += 1 
      end
    end
  
    mytemphash1.clear
    mytemphash1.merge!(mytemphash2)
    puts "=== END #{@totalcount} ============================================" 
      
  end

end # benchmark totaltime
     
puts totaltime
puts "@totalcount: #{@totalcount}"

