class SummarizeService
    attr_reader :query
  
    def initialize(input_text)
      @query = input_text
    end
  
    def summarize_text
      summary = `python3 lib/assets/python/summarize_text.py "#{query}"`
      return summary
    end
  end