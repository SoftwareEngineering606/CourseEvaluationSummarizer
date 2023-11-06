class DuplicateService
  attr_reader :comments

  def initialize(comments)
    @comments = comments
  end

  def remove_duplicates
    unique_comments = []
    comments_str = comments.join("\n") # Convert the list to a newline-separated string
    result = `python3 lib/assets/python/remove_duplicates.py "#{comments_str}"`
    unique_comments = result.split("\n")
    return unique_comments
  end
end