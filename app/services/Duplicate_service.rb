class DuplicateService
  attr_reader :queries

  def initialize(queries)
    @queries = queries
  end

  def remove_duplicates
    unique_comments = []
    result = `python3 lib/assets/python/remove_duplicates.py "#{queries}"`  
    unique_comments = result.split('\n')
    return unique_comments
  end
end