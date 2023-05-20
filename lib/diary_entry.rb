class DiaryEntry
    def initialize(title, contents) # title, contents are strings
      @title = title
      @contents = contents
    end
  
    def title
      return @title
    end
  
    def contents
      return 0 if @contents.empty?
      return @contents
    end

    def count_words
        return @contents.split(" ").length
    end
    
    def reading_time(wpm) 
        fail "Reading speed must be above 0" unless wpm.positive?
        return (count_words / wpm.to_f).ceil    
    end
end