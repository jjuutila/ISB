module Admin::QuestionsHelper
  # Creates an array in a string which can be used as a JavaScript array
  def make_string_array array
    escaped_array = array.collect {|item| sanitize(item.to_s.gsub('"', '\\"')) }
    "[\"#{escaped_array.join('", "')}\"]"
  end
end
